package service

import (
	"log"
	"net"

	grpc_prometheus "github.com/grpc-ecosystem/go-grpc-prometheus"
	consul "github.com/hashicorp/consul/api"
	"github.com/labstack/echo/v4"
	"github.com/prometheus/client_golang/prometheus"
	"google.golang.org/grpc"
)

type (
	Service interface {
		Start() error
	}

	service struct {
		config          *Config
		registry        *prometheus.Registry
		server          interface{}
		grpcDescription *grpc.ServiceDesc
		grpcServer      *grpc.Server
		grpcMetrics     *grpc_prometheus.ServerMetrics
		grpcCounter     *prometheus.CounterVec
		httpServer      *echo.Echo
		registerClient  *consul.Client
	}
)

func Create(server interface{}, description *grpc.ServiceDesc, config *Config) (Service, error) {
	s := &service{
		server:          server,
		grpcDescription: description,
		config:          config,
	}

	err := s.initConfig()
	if err != nil {
		return nil, err
	}

	// Create a metrics registry.
	registry := prometheus.DefaultRegisterer.(*prometheus.Registry)
	s.registry = registry

	// Create some standard server metrics.
	grpcMetrics := grpc_prometheus.NewServerMetrics()
	s.grpcMetrics = grpcMetrics

	// Create a customized counter metric.
	grpcCounter := prometheus.NewCounterVec(prometheus.CounterOpts{
		Name: config.Name + "_server_handle_count",
		Help: "Total number of gRPCs handled on the server.",
	}, []string{"name"})
	s.grpcCounter = grpcCounter

	// Register standard server metrics and customized metrics to registry.
	registry.Register(grpcMetrics)
	registry.Register(grpcCounter)
	grpcCounter.WithLabelValues("Counter")

	// Create a gRPC Server with gRPC interceptor.
	grpcServer := grpc.NewServer(
		grpc.StreamInterceptor(s.grpcMetrics.StreamServerInterceptor()),
		grpc.UnaryInterceptor(s.grpcMetrics.UnaryServerInterceptor()),
	)
	s.grpcServer = grpcServer

	// Register your gRPC service implementations.
	grpcServer.RegisterService(description, server)

	// After all your registrations, make sure all of the Prometheus metrics are initialized.
	grpc_prometheus.Register(grpcServer)

	// Initialize all metrics.
	grpcMetrics.InitializeMetrics(grpcServer)

	// Create a HTTP server for prometheus.
	httpServer := echo.New()
	s.httpServer = httpServer
	httpServer.HideBanner = true
	s.registerHTTPMiddlerware()
	s.registerHTTPFromGRPC()

	return s, nil
}

func (s *service) Start() error {
	lis, err := net.Listen("tcp", address(s.config.GRPC.Port))
	if err != nil {
		return err
	}
	defer lis.Close()

	_, err = s.registerServerToDataCenter()
	if err != nil {
		return err
	}

	go func() {
		err := s.httpServer.Start(address(s.config.HTTP.Port))
		if err != nil {
			log.Fatalf("Unable to start a http server %v", err)
		}
	}()

	if err := s.grpcServer.Serve(lis); err != nil {
		log.Fatalf("Unable to start a grpc server %v", err)
		return err
	}

	return nil
}
