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

	healthCheckURL := baseAddress.ResolveReference(&url.URL{
		Path: "metrics",
	})

	hostName := baseAddress.Hostname()

	client.Agent().ServiceDeregister(s.config.HTTP.Name)

	// Register
	err = client.Agent().ServiceRegister(
		&consul.AgentServiceRegistration{
			Name:    s.config.HTTP.Name,
			ID:      s.config.HTTP.Name,
			Address: hostName,
			Port:    s.config.HTTP.Port,
			Meta: map[string]string{
				grpcAddressLabel: address(s.config.GRPC.Port),
			},
			Check: &consul.AgentServiceCheck{
				HTTP:                           healthCheckURL.String(),
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
