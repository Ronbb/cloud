package main

import (
	"context"
	"time"

	"github.com/ronbb/cloud/servers/internal/database"
	"github.com/ronbb/cloud/servers/internal/token"
	"github.com/ronbb/cloud/servers/models"
	"go.mongodb.org/mongo-driver/mongo"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

var AuthenticationServerDescription *grpc.ServiceDesc

func init() {
	AuthenticationServerDescription = &models.Authentication_ServiceDesc
}

type AuthenticationServer struct {
	models.UnimplementedAuthenticationServer
	UsersCollection     string
	PasswordsCollection string
}

func NewAuthenticationServer() models.AuthenticationServer {
	return &AuthenticationServer{
		UsersCollection:     database.UsersCollection,
		PasswordsCollection: database.PasswordsCollection,
	}
}

func (a *AuthenticationServer) Login(ctx context.Context, request *models.LoginRequest) (*models.LoginResponse, error) {
	userName := request.GetUserName()
	password := request.GetPassword()

	passwords := db.Collection(a.PasswordsCollection)
	result := passwords.FindOne(ctx, database.Filter(&models.Password{
		UserName: userName,
		Password: password,
	}))

	err := result.Err()
	if err != nil && err != mongo.ErrNoDocuments {
		return nil, status.Error(codes.Internal, err.Error())
	}

	if err == mongo.ErrNoDocuments {
		return nil, status.Error(codes.Unauthenticated, "error.login.failed")
	}

	token, err := token.Create(token.Claims{
		IssuedAt: time.Now().Unix(),
		Audience: userName,
		Issuer:   AuthenticationServerDescription.ServiceName,
	})
	if err != nil {
		return nil, status.Error(codes.Internal, err.Error())
	}

	return &models.LoginResponse{
		Token: token,
	}, nil
}

func (a *AuthenticationServer) CreateUser(ctx context.Context, request *models.CreateUserRequest) (*models.CreateUserResponse, error) {
	users := db.Collection(a.UsersCollection)
	passwords := db.Collection(a.PasswordsCollection)

	user := request.GetUser()
	userName := user.GetUserName()
	password := request.GetPassword()

	err := db.Client().UseSession(ctx, func(session mongo.SessionContext) error {
		result := users.FindOne(ctx, database.Filter(&models.User{
			UserName: userName,
		}))

		// user should not exist when creating
		err := result.Err()
		if err == nil {
			return status.Error(codes.InvalidArgument, "error.user.exists")
		}

		if err != mongo.ErrNoDocuments {
			return status.Error(codes.Internal, err.Error())
		}

		// insert user
		_, err = users.InsertOne(ctx, user)
		if err != nil {
			return status.Error(codes.Internal, err.Error())
		}

		_, err = passwords.DeleteMany(
			ctx,
			&models.Password{
				UserName: userName,
			},
		)

		if err != nil {
			return status.Error(codes.Internal, err.Error())
		}

		// insert password
		_, err = passwords.InsertOne(
			ctx,
			&models.Password{
				UserName: userName,
				Password: password,
			},
		)

		if err != nil {
			return status.Error(codes.Internal, err.Error())
		}

		return nil
	})
	if err != nil {
		return nil, err
	}

	return &models.CreateUserResponse{}, nil
}

func (a *AuthenticationServer) KeepAlive(stream models.Authentication_KeepAliveServer) error {
	ticker := time.NewTicker(time.Second * 5)
	received := make(chan *models.HeartBeat)
	receivedError := make(chan error)

	go func() {
		for {
			_, err := stream.Recv()
			if err != nil {
				receivedError <- err
				return
			}
		}
	}()

	for {
		select {
		case <-ticker.C:
			err := stream.Send(&models.HeartBeat{})
			if err != nil {
				return err
			}
		case <-received:
			// do something
		case err := <-receivedError:
			if err != nil {
				return err
			}
		}
	}
}
