package service

import (
	"context"

	"github.com/gorilla/websocket"
	"github.com/labstack/echo/v4"
	"google.golang.org/grpc"
	"google.golang.org/grpc/metadata"
	"google.golang.org/protobuf/proto"
)

var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
}

type (
	websocketAdapter struct {
		conn    *websocket.Conn
		context context.Context
	}
)

func newServerStream(c echo.Context) (grpc.ServerStream, error) {
	conn, err := upgrader.Upgrade(c.Response(), c.Request(), nil)
	if err != nil {
		return nil, err
	}

	wa := &websocketAdapter{
		conn:    conn,
		context: context.Background(),
	}
	return wa, nil
}

func (wa *websocketAdapter) CloseSend() error {
	return wa.conn.Close()
}

func (wa *websocketAdapter) Context() context.Context {
	return nil
}

func (wa *websocketAdapter) SetHeader(metadata.MD) error {
	return nil
}

func (wa *websocketAdapter) SendHeader(metadata.MD) error {
	return nil
}

func (wa *websocketAdapter) SetTrailer(metadata.MD) {
}

func (wa *websocketAdapter) SendMsg(m interface{}) error {
	message, err := proto.Marshal(m.(proto.Message))
	if err != nil {
		return err
	}

	return wa.conn.WriteMessage(websocket.BinaryMessage, message)
}

func (wa *websocketAdapter) RecvMsg(m interface{}) error {
	messageType, message, err := wa.conn.ReadMessage()
	if err != nil {
		return err
	}

	if messageType != websocket.BinaryMessage {
		return nil
	}

	return proto.Unmarshal(message, m.(proto.Message))
}
