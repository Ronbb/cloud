package service

import (
	"net/url"
	"strconv"

	consul "github.com/hashicorp/consul/api"
)

func (s *service) registerServerToDataCenter() (*consul.Client, error) {
	config := consul.DefaultConfig()
	client, err := consul.NewClient(config)
	if err != nil {
		return nil, err
	}
	s.registerClient = client

	address := url.URL{
		Scheme: "http",
		Host:   address(s.config.HTTP.Port),
	}

	healthCheckURL := address.ResolveReference(&url.URL{
		Path: "metrics",
	})

	httpServerPort, err := strconv.Atoi(address.Port())
	if err != nil {
		return nil, err
	}

	err = client.Agent().ServiceRegister(&consul.AgentServiceRegistration{
		Name:    s.config.Name,
		ID:      s.config.Name,
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
