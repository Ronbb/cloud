package main

import (
	"context"
	"net/http"
	"reflect"

	"github.com/labstack/echo/v4"
	"google.golang.org/protobuf/proto"
)

const (
	grpcMethodNumIn  = 2
	grpcMethodNumOut = 2
)

var (
	grpcMethodIn  []reflect.Type
	grpcMethodOut []reflect.Type
)

func init() {
	grpcMethodIn = make([]reflect.Type, grpcMethodNumIn)
	grpcMethodOut = make([]reflect.Type, grpcMethodNumOut)

	ctx := reflect.TypeOf((*context.Context)(nil)).Elem()
	pb := reflect.TypeOf((*proto.Message)(nil)).Elem()
	err := reflect.TypeOf((*error)(nil)).Elem()

	grpcMethodIn[0] = ctx
	grpcMethodIn[1] = pb
	grpcMethodOut[0] = pb
	grpcMethodOut[1] = err
}

func RegisterHTTPFromGRPC(app *echo.Echo, grpc interface{}) {
	ptr := reflect.ValueOf(grpc)
	if ptr.Kind() != reflect.Ptr {
		return
	}
	count := ptr.NumMethod()
	typ := ptr.Type()

method_loop:
	for i := 0; i < count; i++ {
		method := typ.Method(i)
		fun := ptr.Method(i)
		funType := fun.Type()

		if funType.NumIn() != grpcMethodNumIn || funType.NumOut() != grpcMethodNumOut {
			continue
		}

		for in := 0; in < grpcMethodNumIn; in++ {
			if !funType.In(in).Implements(grpcMethodIn[in]) {
				break method_loop
			}
		}

		for out := 0; out < grpcMethodNumOut; out++ {
			if !funType.Out(out).Implements(grpcMethodOut[out]) {
				break method_loop
			}
		}

		app.Any("/"+method.Name, func(c echo.Context) error {
			req := reflect.New(funType.In(1).Elem())

			err := c.Bind(req.Interface())
			if err != nil {
				return err
			}

			rets := fun.Call([]reflect.Value{
				reflect.ValueOf(context.Background()),
				req,
			})

			if !rets[1].IsNil() {
				return rets[1].Interface().(error)
			}

			res := rets[0]
			return c.JSON(http.StatusOK, res.Interface())
		})
	}
}
