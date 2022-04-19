package main

import (
	"context"

	"github.com/ronbb/cloud/servers/models"
)

type BlogServer struct {
	models.UnimplementedBlogServer
}

func NewBlogServer() models.BlogServer {
	return &BlogServer{}
}

func (bs *BlogServer) CreateArticle(context context.Context, request *models.CreateArticleRequest) (*models.CreateArticleResponse, error) {
	return nil, nil
}
