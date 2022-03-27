///
//  Generated code. Do not modify.
//  source: models/api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use routeOptionsDescriptor instead')
const RouteOptions$json = const {
  '1': 'RouteOptions',
  '2': const [
    const {'1': 'method', '3': 1, '4': 1, '5': 9, '10': 'method'},
    const {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `RouteOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeOptionsDescriptor = $convert.base64Decode('CgxSb3V0ZU9wdGlvbnMSFgoGbWV0aG9kGAEgASgJUgZtZXRob2QSEAoDdXJsGAIgASgJUgN1cmw=');
@$core.Deprecated('Use serverOptionsDescriptor instead')
const ServerOptions$json = const {
  '1': 'ServerOptions',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `ServerOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverOptionsDescriptor = $convert.base64Decode('Cg1TZXJ2ZXJPcHRpb25zEhIKBG5hbWUYASABKAlSBG5hbWU=');
@$core.Deprecated('Use httpServerDescriptorDescriptor instead')
const HttpServerDescriptor$json = const {
  '1': 'HttpServerDescriptor',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'routes', '3': 2, '4': 3, '5': 11, '6': '.api.RouteDescriptor', '10': 'routes'},
  ],
};

/// Descriptor for `HttpServerDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List httpServerDescriptorDescriptor = $convert.base64Decode('ChRIdHRwU2VydmVyRGVzY3JpcHRvchISCgRuYW1lGAEgASgJUgRuYW1lEiwKBnJvdXRlcxgCIAMoCzIULmFwaS5Sb3V0ZURlc2NyaXB0b3JSBnJvdXRlcw==');
@$core.Deprecated('Use routeDescriptorDescriptor instead')
const RouteDescriptor$json = const {
  '1': 'RouteDescriptor',
  '2': const [
    const {'1': 'grpc_method', '3': 1, '4': 1, '5': 9, '10': 'grpcMethod'},
    const {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'method', '3': 3, '4': 1, '5': 9, '10': 'method'},
    const {'1': 'is_web_socket', '3': 4, '4': 1, '5': 8, '10': 'isWebSocket'},
  ],
};

/// Descriptor for `RouteDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeDescriptorDescriptor = $convert.base64Decode('Cg9Sb3V0ZURlc2NyaXB0b3ISHwoLZ3JwY19tZXRob2QYASABKAlSCmdycGNNZXRob2QSEAoDdXJsGAIgASgJUgN1cmwSFgoGbWV0aG9kGAMgASgJUgZtZXRob2QSIgoNaXNfd2ViX3NvY2tldBgEIAEoCFILaXNXZWJTb2NrZXQ=');
