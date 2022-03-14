package service

import (
	"net/url"

	consul "github.com/hashicorp/consul/api"
)

func (s *service) registerServerToDataCenter() (*consul.Client, error) {
	config := consul.DefaultConfig()
	client, err := consul.NewClient(config)
	if err != nil {
		return nil, err
	}
	s.registerClient = client

	baseAddress := url.URL{
		Scheme: "http",
		Host:   address(s.config.HTTP.Port),
	}

	httpHealthCheckURL := baseAddress.ResolveReference(&url.URL{
		Path: "metrics",
	})

	grpcHealthCheckURL := baseAddress.ResolveReference(&url.URL{
		Path: "metrics/grpc",
	})

	hostName := baseAddress.Hostname()

	client.Agent().ServiceDeregister(s.config.HTTP.Name)

	client.Agent().ServiceDeregister(s.config.GRPC.Name)

	// Register HTTP
	err = client.Agent().ServiceRegister(
		&consul.AgentServiceRegistration{
			Name:    s.config.HTTP.Name,
			ID:      s.config.HTTP.Name,
			Address: hostName,
			Port:    s.config.HTTP.Port,
			Check: &consul.AgentServiceCheck{
				HTTP:                           httpHealthCheckURL.String(),
				Interval:                       "5s",
				Timeout:                        "3s",
				DeregisterCriticalServiceAfter: "5s",
			},
		},
	)

	if err != nil {
		return client, err
	}

	// Register GRPC
	err = client.Agent().ServiceRegister(
		&consul.AgentServiceRegistration{
			Name:    s.config.GRPC.Name,
			ID:      s.config.GRPC.Name,
			Address: hostName,
			Port:    s.config.GRPC.Port,
			Check: &consul.AgentServiceCheck{
				HTTP:                           grpcHealthCheckURL.String(),
				Interval:                       "5s",
				Timeout:                        "3s",
				DeregisterCriticalServiceAfter: "5s",
			},
		},
	)

	if err != nil {
		return client, err
	}

	return client, nil
}
