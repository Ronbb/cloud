package main

import (
	"context"

	"github.com/ronbb/servers/models"
)

type AuthenticationServer struct {
	models.UnimplementedAuthenticationServer
}

func NewAuthenticationServer() models.AuthenticationServer {
	return &AuthenticationServer{}
}

func (a *AuthenticationServer) Login(ctx context.Context, request *models.LoginRequest) (*models.LoginResponse, error) {
	return nil, nil
}
