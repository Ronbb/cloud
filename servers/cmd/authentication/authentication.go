package main

import (
	"context"
	"log"
	"time"

	"github.com/ronbb/servers/internal/service"
	"github.com/ronbb/servers/models"
)

var AuthenticationServerDescription = &models.Authentication_ServiceDesc

type AuthenticationServer struct {
	models.UnimplementedAuthenticationServer
}

func NewAuthenticationServer() models.AuthenticationServer {
	return &AuthenticationServer{}
}

func (a *AuthenticationServer) Login(ctx context.Context, request *models.LoginRequest) (*models.LoginResponse, error) {
	return &models.LoginResponse{
		Token: "token",
	}, nil
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

func main() {
	s, err := service.Create(
		NewAuthenticationServer(),
		AuthenticationServerDescription,
		&service.Config{
			HTTP: &service.HTTPConfig{
				Port: 5751,
			},
			GRPC: &service.GRPCConfig{
				Port: 5752,
			},
		},
	)
	if err != nil {
		log.Fatal(err.Error())
	}

	err = s.Start()
	if err != nil {
		log.Fatal(err.Error())
	}
}
