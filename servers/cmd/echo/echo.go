package main

import (
	"context"
	"fmt"
	"log"

	consul "github.com/hashicorp/consul/api"
	"github.com/labstack/echo/v4"
	internal_service "github.com/ronbb/cloud/servers/internal/service"
	"github.com/ronbb/cloud/servers/models"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func main() {
	config := consul.DefaultConfig()
	client, err := consul.NewClient(config)
	if err != nil {
		log.Println(err)
	}

	agent := client.Agent()
	service, meta, err := agent.Service("authentication", &consul.QueryOptions{})
	if err != nil {
		log.Println(err)
	}

	fmt.Printf("%v %v\n", service, meta)
	grpcAddress, ok := service.Meta[internal_service.GRPCAddressLabel]
	if !ok {
		log.Println("grpc address not found")
	}

	conn, err := grpc.Dial(grpcAddress, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Println(err)
	}

	authentication := models.NewAuthenticationClient(conn)
	response, err := authentication.Login(context.Background(), &models.LoginRequest{})
	if err != nil {
		log.Println(err)
	}
	log.Printf("%v\n", response)

	app := echo.New()
	app.Start(":8089")
}
