package service

import (
	"context"
	"net/http"
	"reflect"
	"strings"

	"github.com/labstack/echo-contrib/prometheus"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/ronbb/cloud/utils/casing"
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
	name := s.config.HTTP.Name
	server := reflect.ValueOf(s.server)

	description := s.grpcDescription
	methodDescriptions := description.Methods
	streamDescriptions := description.Streams

	path := func(api string) string {
		return "/" + name + "/" + casing.Snake(api)
	}

	extractMethod := func(api string) (method, restPath string) {
		method = http.MethodPost
		separator := "_"
		splitted := strings.Split(path(api), separator)
		if len(splitted) < 2 {
			restPath = strings.Join(splitted, separator)
			return
		}

		methodRaw := splitted[0]
		restPath = strings.Join(splitted[1:], separator)

		switch methodRaw {
		case "create":
		case "add":
			method = http.MethodPost
		case "update":
		case "modify":
			method = http.MethodPut
		case "remove":
		case "delete":
			method = http.MethodDelete
		case "query":
		case "get":
			method = http.MethodGet
		}

		return
	}

	for _, description := range methodDescriptions {
		name := description.MethodName
		method := server.MethodByName(name)

		httpMethod, path := extractMethod(name)

		s.httpServer.Add(httpMethod, path, func(c echo.Context) error {
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

	for _, description := range streamDescriptions {
		name := description.StreamName
		handler := description.Handler

		s.httpServer.Any(path(name), func(c echo.Context) error {
			ss, err := newServerStream(c)
			if err != nil {
				return err
			}
			handler(s.server, ss)
			return nil
		})
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
