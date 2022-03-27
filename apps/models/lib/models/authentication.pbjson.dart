///
//  Generated code. Do not modify.
//  source: models/authentication.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = const {
  '1': 'LoginRequest',
  '2': const [
    const {'1': 'user_name', '3': 1, '4': 1, '5': 9, '10': 'userName'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode('CgxMb2dpblJlcXVlc3QSGwoJdXNlcl9uYW1lGAEgASgJUgh1c2VyTmFtZRIaCghwYXNzd29yZBgCIAEoCVIIcGFzc3dvcmQ=');
@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = const {
  '1': 'LoginResponse',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert.base64Decode('Cg1Mb2dpblJlc3BvbnNlEhQKBXRva2VuGAEgASgJUgV0b2tlbg==');
@$core.Deprecated('Use createUserRequestDescriptor instead')
const CreateUserRequest$json = const {
  '1': 'CreateUserRequest',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.authentication.User', '10': 'user'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `CreateUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUserRequestDescriptor = $convert.base64Decode('ChFDcmVhdGVVc2VyUmVxdWVzdBIoCgR1c2VyGAEgASgLMhQuYXV0aGVudGljYXRpb24uVXNlclIEdXNlchIaCghwYXNzd29yZBgCIAEoCVIIcGFzc3dvcmQ=');
@$core.Deprecated('Use createUserResponseDescriptor instead')
const CreateUserResponse$json = const {
  '1': 'CreateUserResponse',
};

/// Descriptor for `CreateUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUserResponseDescriptor = $convert.base64Decode('ChJDcmVhdGVVc2VyUmVzcG9uc2U=');
@$core.Deprecated('Use heartBeatDescriptor instead')
const HeartBeat$json = const {
  '1': 'HeartBeat',
};

/// Descriptor for `HeartBeat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heartBeatDescriptor = $convert.base64Decode('CglIZWFydEJlYXQ=');
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'user_name', '3': 1, '4': 1, '5': 9, '10': 'userName'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEhsKCXVzZXJfbmFtZRgBIAEoCVIIdXNlck5hbWU=');
@$core.Deprecated('Use passwordDescriptor instead')
const Password$json = const {
  '1': 'Password',
  '2': const [
    const {'1': 'user_name', '3': 1, '4': 1, '5': 9, '10': 'userName'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `Password`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List passwordDescriptor = $convert.base64Decode('CghQYXNzd29yZBIbCgl1c2VyX25hbWUYASABKAlSCHVzZXJOYW1lEhoKCHBhc3N3b3JkGAIgASgJUghwYXNzd29yZA==');
const $core.Map<$core.String, $core.dynamic> AuthenticationServiceBase$json = const {
  '1': 'Authentication',
  '2': const [
    const {'1': 'Login', '2': '.authentication.LoginRequest', '3': '.authentication.LoginResponse', '4': const {}},
    const {'1': 'CreateUser', '2': '.authentication.CreateUserRequest', '3': '.authentication.CreateUserResponse', '4': const {}},
    const {'1': 'KeepAlive', '2': '.authentication.HeartBeat', '3': '.authentication.HeartBeat', '4': const {}, '5': true, '6': true},
  ],
  '3': const {},
};

@$core.Deprecated('Use authenticationServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> AuthenticationServiceBase$messageJson = const {
  '.authentication.LoginRequest': LoginRequest$json,
  '.authentication.LoginResponse': LoginResponse$json,
  '.authentication.CreateUserRequest': CreateUserRequest$json,
  '.authentication.User': User$json,
  '.authentication.CreateUserResponse': CreateUserResponse$json,
  '.authentication.HeartBeat': HeartBeat$json,
};

/// Descriptor for `Authentication`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List authenticationServiceDescriptor = $convert.base64Decode('Cg5BdXRoZW50aWNhdGlvbhJYCgVMb2dpbhIcLmF1dGhlbnRpY2F0aW9uLkxvZ2luUmVxdWVzdBodLmF1dGhlbnRpY2F0aW9uLkxvZ2luUmVzcG9uc2UiEsK7AQ4KBHBvc3QSBi9sb2dpbhJmCgpDcmVhdGVVc2VyEiEuYXV0aGVudGljYXRpb24uQ3JlYXRlVXNlclJlcXVlc3QaIi5hdXRoZW50aWNhdGlvbi5DcmVhdGVVc2VyUmVzcG9uc2UiEcK7AQ0KBHBvc3QSBS91c2VyElgKCUtlZXBBbGl2ZRIZLmF1dGhlbnRpY2F0aW9uLkhlYXJ0QmVhdBoZLmF1dGhlbnRpY2F0aW9uLkhlYXJ0QmVhdCIRwrsBDRILL2tlZXBfYWxpdmUoATABGhTCuwEQCg5hdXRoZW50aWNhdGlvbg==');
