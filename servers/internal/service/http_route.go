package service

import (
	"context"
	"net/http"
	"reflect"
	"strings"

	"github.com/labstack/echo-contrib/prometheus"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"google.golang.org/grpc"
	"google.golang.org/grpc/status"
)

const (
	grpcMethodNumIn            = 2
	grpcMethodNumOut           = 2
	grpcMethodInContextIndex   = 0
	grpcMethodInRequestIndex   = 1
	grpcMethodOutResponseIndex = 0
	grpcMethodOutErrorIndex    = 1
	grpcStreamNumIn            = 1
	grpcStreamNumOut           = 1
)

func (s *service) registerHTTPFromGRPC() {
	server := reflect.ValueOf(s.server)

	grpcDescriptor := s.grpcDescriptor

	for _, route := range s.httpDescriptor.Routes {
		method := server.MethodByName(route.GrpcMethod)
		if route.IsWebSocket {
			var handler grpc.StreamHandler
			for _, stream := range grpcDescriptor.Streams {
				if stream.StreamName == route.GrpcMethod {
					handler = stream.Handler
				}
			}
			if handler != nil {
				s.httpServer.GET(route.Url, func(c echo.Context) error {
					ss, err := newServerStream(c)
					if err != nil {
						return err
					}
					handler(s.server, ss)
					return nil
				})
			}
		} else {
			s.httpServer.Add(route.Method, route.Url, func(c echo.Context) error {
				request := reflect.New(method.Type().In(grpcMethodInRequestIndex).Elem())

				err := c.Bind(request.Interface())
				if err != nil {
					return err
				}

				returns := method.Call([]reflect.Value{
					reflect.ValueOf(context.Background()),
					request,
				})

				returnError := returns[grpcMethodOutErrorIndex]
				if !returnError.IsNil() {
					err = returnError.Interface().(error)
					status := status.Convert(err)

					return c.String(
						convertGRPCStatusToHTTPStatus(status.Code()),
						status.Message(),
					)
				}

				response := returns[grpcMethodOutResponseIndex]
				return c.JSON(http.StatusOK, response.Interface())
			})
		}

	}
}

func (s *service) registerHTTPMiddlerware() {
	s.httpServer.JSONSerializer = &JSONSerializer{}
	s.httpServer.Use(middleware.Recover())
	prometheus.NewPrometheus(
		s.config.HTTP.Name,
		func(c echo.Context) bool {
			return strings.HasPrefix(c.Request().URL.Path, "/metrics")
		},
	).Use(s.httpServer)
}
