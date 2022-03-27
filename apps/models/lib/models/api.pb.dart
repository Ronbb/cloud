///
//  Generated code. Do not modify.
//  source: models/api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RouteOptions extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RouteOptions', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'method')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..hasRequiredFields = false
  ;

  RouteOptions._() : super();
  factory RouteOptions({
    $core.String? method,
    $core.String? url,
  }) {
    final _result = create();
    if (method != null) {
      _result.method = method;
    }
    if (url != null) {
      _result.url = url;
    }
    return _result;
  }
  factory RouteOptions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RouteOptions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RouteOptions clone() => RouteOptions()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RouteOptions copyWith(void Function(RouteOptions) updates) => super.copyWith((message) => updates(message as RouteOptions)) as RouteOptions; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RouteOptions create() => RouteOptions._();
  RouteOptions createEmptyInstance() => create();
  static $pb.PbList<RouteOptions> createRepeated() => $pb.PbList<RouteOptions>();
  @$core.pragma('dart2js:noInline')
  static RouteOptions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RouteOptions>(create);
  static RouteOptions? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get method => $_getSZ(0);
  @$pb.TagNumber(1)
  set method($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethod() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get url => $_getSZ(1);
  @$pb.TagNumber(2)
  set url($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUrl() => clearField(2);
}

class ServerOptions extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ServerOptions', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  ServerOptions._() : super();
  factory ServerOptions({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory ServerOptions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ServerOptions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ServerOptions clone() => ServerOptions()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ServerOptions copyWith(void Function(ServerOptions) updates) => super.copyWith((message) => updates(message as ServerOptions)) as ServerOptions; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ServerOptions create() => ServerOptions._();
  ServerOptions createEmptyInstance() => create();
  static $pb.PbList<ServerOptions> createRepeated() => $pb.PbList<ServerOptions>();
  @$core.pragma('dart2js:noInline')
  static ServerOptions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ServerOptions>(create);
  static ServerOptions? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class HttpServerDescriptor extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HttpServerDescriptor', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<RouteDescriptor>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'routes', $pb.PbFieldType.PM, subBuilder: RouteDescriptor.create)
    ..hasRequiredFields = false
  ;

  HttpServerDescriptor._() : super();
  factory HttpServerDescriptor({
    $core.String? name,
    $core.Iterable<RouteDescriptor>? routes,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (routes != null) {
      _result.routes.addAll(routes);
    }
    return _result;
  }
  factory HttpServerDescriptor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HttpServerDescriptor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HttpServerDescriptor clone() => HttpServerDescriptor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HttpServerDescriptor copyWith(void Function(HttpServerDescriptor) updates) => super.copyWith((message) => updates(message as HttpServerDescriptor)) as HttpServerDescriptor; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HttpServerDescriptor create() => HttpServerDescriptor._();
  HttpServerDescriptor createEmptyInstance() => create();
  static $pb.PbList<HttpServerDescriptor> createRepeated() => $pb.PbList<HttpServerDescriptor>();
  @$core.pragma('dart2js:noInline')
  static HttpServerDescriptor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HttpServerDescriptor>(create);
  static HttpServerDescriptor? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<RouteDescriptor> get routes => $_getList(1);
}

class RouteDescriptor extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RouteDescriptor', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'grpcMethod')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'method')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isWebSocket')
    ..hasRequiredFields = false
  ;

  RouteDescriptor._() : super();
  factory RouteDescriptor({
    $core.String? grpcMethod,
    $core.String? url,
    $core.String? method,
    $core.bool? isWebSocket,
  }) {
    final _result = create();
    if (grpcMethod != null) {
      _result.grpcMethod = grpcMethod;
    }
    if (url != null) {
      _result.url = url;
    }
    if (method != null) {
      _result.method = method;
    }
    if (isWebSocket != null) {
      _result.isWebSocket = isWebSocket;
    }
    return _result;
  }
  factory RouteDescriptor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RouteDescriptor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RouteDescriptor clone() => RouteDescriptor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RouteDescriptor copyWith(void Function(RouteDescriptor) updates) => super.copyWith((message) => updates(message as RouteDescriptor)) as RouteDescriptor; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RouteDescriptor create() => RouteDescriptor._();
  RouteDescriptor createEmptyInstance() => create();
  static $pb.PbList<RouteDescriptor> createRepeated() => $pb.PbList<RouteDescriptor>();
  @$core.pragma('dart2js:noInline')
  static RouteDescriptor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RouteDescriptor>(create);
  static RouteDescriptor? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get grpcMethod => $_getSZ(0);
  @$pb.TagNumber(1)
  set grpcMethod($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGrpcMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearGrpcMethod() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get url => $_getSZ(1);
  @$pb.TagNumber(2)
  set url($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUrl() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get method => $_getSZ(2);
  @$pb.TagNumber(3)
  set method($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMethod() => $_has(2);
  @$pb.TagNumber(3)
  void clearMethod() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isWebSocket => $_getBF(3);
  @$pb.TagNumber(4)
  set isWebSocket($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsWebSocket() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsWebSocket() => clearField(4);
}

class Api {
  static final route = $pb.Extension<RouteOptions>(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'google.protobuf.MethodOptions', const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'route', 3000, $pb.PbFieldType.OM, defaultOrMaker: RouteOptions.getDefault, subBuilder: RouteOptions.create);
  static final server = $pb.Extension<ServerOptions>(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'google.protobuf.ServiceOptions', const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'server', 3000, $pb.PbFieldType.OM, defaultOrMaker: ServerOptions.getDefault, subBuilder: ServerOptions.create);
  static void registerAllExtensions($pb.ExtensionRegistry registry) {
    registry.add(route);
    registry.add(server);
  }
}

