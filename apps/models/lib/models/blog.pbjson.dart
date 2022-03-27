///
//  Generated code. Do not modify.
//  source: models/blog.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use articleDescriptor instead')
const Article$json = const {
  '1': 'Article',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'content', '3': 3, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'author_id', '3': 4, '4': 1, '5': 9, '10': 'authorId'},
    const {'1': 'keys', '3': 5, '4': 3, '5': 9, '10': 'keys'},
  ],
};

/// Descriptor for `Article`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List articleDescriptor = $convert.base64Decode('CgdBcnRpY2xlEg4KAmlkGAEgASgJUgJpZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSGAoHY29udGVudBgDIAEoCVIHY29udGVudBIbCglhdXRob3JfaWQYBCABKAlSCGF1dGhvcklkEhIKBGtleXMYBSADKAlSBGtleXM=');
@$core.Deprecated('Use createArticleRequestDescriptor instead')
const CreateArticleRequest$json = const {
  '1': 'CreateArticleRequest',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'author_id', '3': 2, '4': 1, '5': 9, '10': 'authorId'},
  ],
};

/// Descriptor for `CreateArticleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createArticleRequestDescriptor = $convert.base64Decode('ChRDcmVhdGVBcnRpY2xlUmVxdWVzdBIUCgV0aXRsZRgBIAEoCVIFdGl0bGUSGwoJYXV0aG9yX2lkGAIgASgJUghhdXRob3JJZA==');
@$core.Deprecated('Use createArticleResponseDescriptor instead')
const CreateArticleResponse$json = const {
  '1': 'CreateArticleResponse',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `CreateArticleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createArticleResponseDescriptor = $convert.base64Decode('ChVDcmVhdGVBcnRpY2xlUmVzcG9uc2USDgoCaWQYASABKAlSAmlk');
@$core.Deprecated('Use getArticleRequestDescriptor instead')
const GetArticleRequest$json = const {
  '1': 'GetArticleRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetArticleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getArticleRequestDescriptor = $convert.base64Decode('ChFHZXRBcnRpY2xlUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated('Use getArticleResponseDescriptor instead')
const GetArticleResponse$json = const {
  '1': 'GetArticleResponse',
  '2': const [
    const {'1': 'article', '3': 1, '4': 1, '5': 11, '6': '.blog.Article', '10': 'article'},
  ],
};

/// Descriptor for `GetArticleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getArticleResponseDescriptor = $convert.base64Decode('ChJHZXRBcnRpY2xlUmVzcG9uc2USJwoHYXJ0aWNsZRgBIAEoCzINLmJsb2cuQXJ0aWNsZVIHYXJ0aWNsZQ==');
const $core.Map<$core.String, $core.dynamic> BlogServiceBase$json = const {
  '1': 'Blog',
  '2': const [
    const {'1': 'CreateArticle', '2': '.blog.CreateArticleRequest', '3': '.blog.CreateArticleResponse', '4': const {}},
  ],
  '3': const {},
};

@$core.Deprecated('Use blogServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> BlogServiceBase$messageJson = const {
  '.blog.CreateArticleRequest': CreateArticleRequest$json,
  '.blog.CreateArticleResponse': CreateArticleResponse$json,
};

/// Descriptor for `Blog`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List blogServiceDescriptor = $convert.base64Decode('CgRCbG9nEl4KDUNyZWF0ZUFydGljbGUSGi5ibG9nLkNyZWF0ZUFydGljbGVSZXF1ZXN0GhsuYmxvZy5DcmVhdGVBcnRpY2xlUmVzcG9uc2UiFMK7ARAKBHBvc3QSCC9hcnRpY2xlGgrCuwEGCgRibG9n');
