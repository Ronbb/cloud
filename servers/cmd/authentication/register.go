package main

import (
	"net/url"
	"strconv"

	consul "github.com/hashicorp/consul/api"
)

func RegisterServer(name, host string) (*consul.Client, error) {
	config := consul.DefaultConfig()
	client, err := consul.NewClient(config)
	if err != nil {
		return nil, err
	}

	address := url.URL{
		Host: host,
	}

	address.Scheme = "http"
	if address.Hostname() == "" {
		address.Host = "127.0.0.1" + address.Host
	}
	healthCheckURL := address.ResolveReference(&url.URL{
		Path: "metrics",
	})

	httpServerPort, err := strconv.Atoi(address.Port())
	if err != nil {
		return nil, err
	}

	err = client.Agent().ServiceRegister(&consul.AgentServiceRegistration{
		Name:    name,
		ID:      name,
		Address: address.Hostname(),
		Port:    httpServerPort,
		Check: &consul.AgentServiceCheck{
			HTTP:     healthCheckURL.String(),
			Interval: "5s",
			Timeout:  "3s",
		},
	})

	if err != nil {
		return client, err
	}

	return client, nil
}
