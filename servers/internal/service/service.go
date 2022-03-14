package service

import (
	"log"
	"net"
	"net/http"

	grpc_prometheus "github.com/grpc-ecosystem/go-grpc-prometheus"
	consul "github.com/hashicorp/consul/api"
	"github.com/labstack/echo/v4"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"google.golang.org/grpc"
)

type (
	Service interface{}

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

	// Create a metrics registry.
	registry := prometheus.NewRegistry()
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
	registry.MustRegister(grpcMetrics, grpcCounter)
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

	// Register Prometheus metrics handler.
	http.Handle("/metrics", promhttp.Handler())

	// Create a HTTP server for prometheus.
	httpServer := echo.New()
	s.httpServer = httpServer
	s.registerHTTPMiddlerware()
	s.registerHTTPFromGRPC()
	httpServer.Any(
		"/metrics/grpc",
		echo.WrapHandler(
			promhttp.HandlerFor(
				registry,
				promhttp.HandlerOpts{},
			),
		),
	)

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
