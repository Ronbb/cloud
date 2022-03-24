package service

import (
	"fmt"
	"net"
	"net/http"

	"google.golang.org/grpc/codes"
)

var grpcHTTPStatusMap = map[codes.Code]int{
	codes.OK:                 http.StatusOK,
	codes.Canceled:           http.StatusNoContent,
	codes.Unknown:            http.StatusInternalServerError,
	codes.InvalidArgument:    http.StatusBadRequest,
	codes.DeadlineExceeded:   http.StatusGatewayTimeout,
	codes.NotFound:           http.StatusNotFound,
	codes.AlreadyExists:      http.StatusConflict,
	codes.PermissionDenied:   http.StatusForbidden,
	codes.ResourceExhausted:  http.StatusRequestEntityTooLarge,
	codes.FailedPrecondition: http.StatusPreconditionFailed,
	codes.Aborted:            http.StatusInternalServerError,
	codes.OutOfRange:         http.StatusPreconditionFailed,
	codes.Unimplemented:      http.StatusNotImplemented,
	codes.Internal:           http.StatusInternalServerError,
	codes.Unavailable:        http.StatusServiceUnavailable,
	codes.DataLoss:           http.StatusGone,
	codes.Unauthenticated:    http.StatusUnauthorized,
}

func convertGRPCStatusToHTTPStatus(code codes.Code) int {
	result, found := grpcHTTPStatusMap[code]
	if !found {
		return http.StatusInternalServerError
	}

	return result
}

func address(port int) string {
	return net.JoinHostPort("127.0.0.1", fmt.Sprint(port))
}
