package service

import (
	"io"

	"github.com/labstack/echo/v4"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

type JSONSerializer struct{}

func (js *JSONSerializer) Serialize(c echo.Context, i interface{}, indent string) error {
	message, ok := i.(proto.Message)
	if !ok {
		return echo.DefaultJSONSerializer{}.Serialize(c, i, indent)
	}

	bytes, err := protojson.MarshalOptions{
		Indent: indent,
	}.Marshal(message)
	if err != nil {
		return err
	}

	_, err = c.Response().Write(bytes)
	return err
}

func (js *JSONSerializer) Deserialize(c echo.Context, i interface{}) error {
	message, ok := i.(proto.Message)
	if !ok {
		return echo.DefaultJSONSerializer{}.Deserialize(c, i)
	}

	bytes, err := io.ReadAll(c.Request().Body)
	if err != nil {
		return err
	}

	return protojson.Unmarshal(bytes, message)
}
