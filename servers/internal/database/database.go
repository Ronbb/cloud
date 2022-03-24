package database

import (
	"context"
	"reflect"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"google.golang.org/protobuf/proto"
)

const (
	Address             = "mongodb://localhost:27017"
	UsersCollection     = "Users"
	PasswordsCollection = "Passwords"
)

var protoType = reflect.TypeOf((*proto.Message)(nil)).Elem()

func Client() (*mongo.Client, error) {
	registry := bson.NewRegistryBuilder()
	codec := &Codec{}
	registry.RegisterHookDecoder(protoType, codec)
	registry.RegisterHookEncoder(protoType, codec)

	return mongo.Connect(
		context.Background(),
		options.Client().ApplyURI(Address).SetRegistry(registry.Build()),
	)
}

func Filter(message proto.Message) bson.D {
	// TODO
	return FlattenOptions{}.Flatten(message)
}
