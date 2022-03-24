package main

import (
	"context"
	"testing"

	"github.com/ronbb/servers/models"
	"github.com/stretchr/testify/assert"
)

const (
	testUsersCollection     = "Users_Test"
	testPasswordsCollection = "Passwords_Test"
	testUserName            = "TestUser"
	testPassword            = "TestPassword"
)

func TestAuthenticationServer(t *testing.T) {
	var server *AuthenticationServer

	t.Run("init server", func(t *testing.T) {
		assert := assert.New(t)

		// create server
		server = NewAuthenticationServer().(*AuthenticationServer)
		assert.NotNil(server)

		server.UsersCollection = testUsersCollection
		server.PasswordsCollection = testPasswordsCollection

		// drop test collection
		assert.Nil(db.Collection(testUsersCollection).Drop(context.Background()))
		assert.Nil(db.Collection(testPasswordsCollection).Drop(context.Background()))
	})

	t.Run("create user", func(t *testing.T) {
		assert := assert.New(t)

		// create user
		response, err := server.CreateUser(context.Background(), &models.CreateUserRequest{
			User: &models.User{
				UserName: testUserName,
			},
			Password: testPassword,
		})

		assert.NotNil(response)
		assert.Nilf(err, "%s", err)

		// create duplicate user
		response, err = server.CreateUser(context.Background(), &models.CreateUserRequest{
			User: &models.User{
				UserName: testUserName,
			},
			Password: "password",
		})

		assert.Nil(response)
		assert.NotNilf(err, "%s", err)
	})

	t.Run("login", func(t *testing.T) {
		assert := assert.New(t)

		// login successfully
		response, err := server.Login(context.Background(), &models.LoginRequest{
			UserName: testUserName,
			Password: testPassword,
		})

		assert.NotNil(response)
		assert.Nilf(err, "%s", err)

		// login failed
		response, err = server.Login(context.Background(), &models.LoginRequest{
			UserName: testUserName,
			Password: testPassword + "error",
		})

		assert.Nil(response)
		assert.NotNilf(err, "%s", err)
	})
}
