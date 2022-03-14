package service

type (
	Config struct {
		Name string
		HTTP *HTTPConfig
		GRPC *GRPCConfig
	}

	HTTPConfig struct {
		Port int
	}

	GRPCConfig struct {
		Port int
	}
)
