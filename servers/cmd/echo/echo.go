package main

import (
	"fmt"

	consul "github.com/hashicorp/consul/api"
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

	fmt.Printf("%v %v", service, meta)
}
