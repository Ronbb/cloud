///
//  Generated code. Do not modify.
//  source: models/blog.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'blog.pb.dart' as $1;
import 'blog.pbjson.dart';

export 'blog.pb.dart';

abstract class BlogServiceBase extends $pb.GeneratedService {
  $async.Future<$1.CreateArticleResponse> createArticle($pb.ServerContext ctx, $1.CreateArticleRequest request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'CreateArticle': return $1.CreateArticleRequest();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'CreateArticle': return this.createArticle(ctx, request as $1.CreateArticleRequest);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => BlogServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => BlogServiceBase$messageJson;
}

