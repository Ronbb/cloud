// Code generated by protoc-gen-go-grpc. DO NOT EDIT.
// versions:
// - protoc-gen-go-grpc v1.2.0
// - protoc             v3.12.4
// source: models/blog.proto

package models

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
// Requires gRPC-Go v1.32.0 or later.
const _ = grpc.SupportPackageIsVersion7

// BlogClient is the client API for Blog service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type BlogClient interface {
	// create article
	CreateArticle(ctx context.Context, in *CreateArticleRequest, opts ...grpc.CallOption) (*CreateArticleResponse, error)
}

type blogClient struct {
	cc grpc.ClientConnInterface
}

func NewBlogClient(cc grpc.ClientConnInterface) BlogClient {
	return &blogClient{cc}
}

func (c *blogClient) CreateArticle(ctx context.Context, in *CreateArticleRequest, opts ...grpc.CallOption) (*CreateArticleResponse, error) {
	out := new(CreateArticleResponse)
	err := c.cc.Invoke(ctx, "/blog.Blog/CreateArticle", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// BlogServer is the server API for Blog service.
// All implementations must embed UnimplementedBlogServer
// for forward compatibility
type BlogServer interface {
	// create article
	CreateArticle(context.Context, *CreateArticleRequest) (*CreateArticleResponse, error)
	mustEmbedUnimplementedBlogServer()
}

// UnimplementedBlogServer must be embedded to have forward compatible implementations.
type UnimplementedBlogServer struct {
}

func (UnimplementedBlogServer) CreateArticle(context.Context, *CreateArticleRequest) (*CreateArticleResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method CreateArticle not implemented")
}
func (UnimplementedBlogServer) mustEmbedUnimplementedBlogServer() {}

// UnsafeBlogServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to BlogServer will
// result in compilation errors.
type UnsafeBlogServer interface {
	mustEmbedUnimplementedBlogServer()
}

func RegisterBlogServer(s grpc.ServiceRegistrar, srv BlogServer) {
	s.RegisterService(&Blog_ServiceDesc, srv)
}

func _Blog_CreateArticle_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(CreateArticleRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BlogServer).CreateArticle(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/blog.Blog/CreateArticle",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BlogServer).CreateArticle(ctx, req.(*CreateArticleRequest))
	}
	return interceptor(ctx, in, info, handler)
}

// Blog_ServiceDesc is the grpc.ServiceDesc for Blog service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var Blog_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "blog.Blog",
	HandlerType: (*BlogServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "CreateArticle",
			Handler:    _Blog_CreateArticle_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "models/blog.proto",
}
