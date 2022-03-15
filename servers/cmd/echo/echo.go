package main

import (
	"context"
	"fmt"

	consul "github.com/hashicorp/consul/api"
	internal_service "github.com/ronbb/servers/internal/service"
	"github.com/ronbb/servers/models"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func main() {
	config := consul.DefaultConfig()
	client, err := consul.NewClient(config)
	if err != nil {
		panic(err)
	}

	agent := client.Agent()
	service, meta, err := agent.Service("authentication", &consul.QueryOptions{})
	if err != nil {
		panic(err)
	}

	fmt.Printf("%v %v\n", service, meta)
	grpcAddress, ok := service.Meta[internal_service.GRPCAddressLabel]
	if !ok {
		panic("grpc address not found")
	}

	conn, err := grpc.Dial(grpcAddress, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		panic(err)
	}

	authentication := models.NewAuthenticationClient(conn)
	response, err := authentication.Login(context.Background(), &models.LoginRequest{})
	if err != nil {
		panic(err)
	}
	fmt.Printf("%v\n", response)
}
