///
//  Generated code. Do not modify.
//  source: models/authentication.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'authentication.pb.dart' as $0;
import 'authentication.pbjson.dart';

export 'authentication.pb.dart';

abstract class AuthenticationServiceBase extends $pb.GeneratedService {
  $async.Future<$0.LoginResponse> login($pb.ServerContext ctx, $0.LoginRequest request);
  $async.Future<$0.CreateUserResponse> createUser($pb.ServerContext ctx, $0.CreateUserRequest request);
  $async.Future<$0.HeartBeat> keepAlive($pb.ServerContext ctx, $0.HeartBeat request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'Login': return $0.LoginRequest();
      case 'CreateUser': return $0.CreateUserRequest();
      case 'KeepAlive': return $0.HeartBeat();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'Login': return this.login(ctx, request as $0.LoginRequest);
      case 'CreateUser': return this.createUser(ctx, request as $0.CreateUserRequest);
      case 'KeepAlive': return this.keepAlive(ctx, request as $0.HeartBeat);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => AuthenticationServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => AuthenticationServiceBase$messageJson;
}

