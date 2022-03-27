package main

import (
	"log"

	"github.com/ronbb/cloud/servers/internal/database"
	"github.com/ronbb/cloud/servers/internal/service"
	"go.mongodb.org/mongo-driver/mongo"
)

var db *mongo.Database

func init() {
	client, err := database.Client()
	if err != nil {
		log.Fatal(err)
	}

	db = client.Database(AuthenticationGRPCServerDescriptor.ServiceName)
}

func main() {
	s, err := service.Create(
		NewAuthenticationServer(),
		AuthenticationGRPCServerDescriptor,
		AuthenticationHTTPServerDescriptor,
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
