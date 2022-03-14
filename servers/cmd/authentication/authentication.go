package main

import "github.com/ronbb/servers/internal/service"

func main() {
	s, err := service.Create(
		NewAuthenticationServer(),
		AuthenticationServerDescription,
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
		panic(err.Error())
	}

	err = s.Start()
	if err != nil {
		panic(err.Error())
	}
}
