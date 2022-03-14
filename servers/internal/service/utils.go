package service

import (
	"fmt"
	"net"
)

func address(port int) string {
	return net.JoinHostPort("127.0.0.1", fmt.Sprint(port))
}
