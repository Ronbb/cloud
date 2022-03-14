package service

import (
	"fmt"
	"net"
)

func address(port int) string {
	return net.JoinHostPort("localhost", fmt.Sprint(port))
}
