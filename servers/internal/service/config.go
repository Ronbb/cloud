package service

import (
	"errors"

	"github.com/ronbb/cloud/utils"
)

type (
	Config struct {
		Name string
		HTTP *HTTPConfig
		GRPC *GRPCConfig
	}

	HTTPConfig struct {
		Name string
		Port int
	}

	GRPCConfig struct {
		Name string
		Port int
	}
)

func (s *service) initConfig() error {
	if s.config == nil || s.server == nil || s.grpcDescription == nil {
		return errors.New("service config/server/description should not be nil")
	}

	if s.config.HTTP.Port == 0 || s.config.GRPC.Port == 0 {
		return errors.New("must specify port")
	}

	if s.config.Name == "" {
		s.config.Name = utils.ToSnakeCase(s.grpcDescription.ServiceName)
	}

	if s.config.GRPC.Name == "" {
		s.config.GRPC.Name = s.config.Name
	}

	if s.config.HTTP.Name == "" {
		s.config.HTTP.Name = s.config.Name
	}

	return nil
}
