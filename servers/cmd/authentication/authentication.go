package main

import (
	"log"
	"net"
	"net/http"

	grpc_prometheus "github.com/grpc-ecosystem/go-grpc-prometheus"
	"github.com/labstack/echo/v4"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"github.com/ronbb/servers/models"
	"google.golang.org/grpc"
)

const (
	httpPort = "5751"
	grpcPort = "5752"
)

var (
	// Create a metrics registry.
	reg = prometheus.NewRegistry()

	// Create some standard server metrics.
	grpcMetrics = grpc_prometheus.NewServerMetrics()

	// Create a customized counter metric.
	customizedCounterMetric = prometheus.NewCounterVec(prometheus.CounterOpts{
		Name: "demo_server_say_hello_method_handle_count",
		Help: "Total number of RPCs handled on the server.",
	}, []string{"name"})
)

func init() {
	// Register standard server metrics and customized metrics to registry.
	reg.MustRegister(grpcMetrics, customizedCounterMetric)
	customizedCounterMetric.WithLabelValues("Test")
}

func main() {
	lis, err := net.Listen("tcp", net.JoinHostPort("127.0.0.1", grpcPort))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	defer lis.Close()

	// Create a gRPC Server with gRPC interceptor.
	grpcServer := grpc.NewServer(
		grpc.StreamInterceptor(grpcMetrics.StreamServerInterceptor()),
		grpc.UnaryInterceptor(grpcMetrics.UnaryServerInterceptor()),
	)

	authServer := NewAuthenticationServer()

	// Register your gRPC service implementations.
	models.RegisterAuthenticationServer(grpcServer, authServer)

	// After all your registrations, make sure all of the Prometheus metrics are initialized.
	grpc_prometheus.Register(grpcServer)

	grpcMetrics.InitializeMetrics(grpcServer)

	// Register Prometheus metrics handler.
	http.Handle("/metrics", promhttp.Handler())

	// Create a HTTP server for prometheus.
	httpServer := echo.New()
	RegisterHTTPFromGRPC(httpServer, authServer)
	httpServer.Any("/metrics", echo.WrapHandler(promhttp.HandlerFor(reg, promhttp.HandlerOpts{})))
	go func() {
		err := httpServer.Start(net.JoinHostPort("127.0.0.1", httpPort))
		if err != nil {
			log.Fatalf("Unable to start a http server %v", err)
		}
	}()

	if err := grpcServer.Serve(lis); err != nil {
		log.Fatalf("Unable to start a grpc server %v", err)
	}
}
