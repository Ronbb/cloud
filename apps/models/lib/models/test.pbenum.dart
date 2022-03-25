///
//  Generated code. Do not modify.
//  source: models/test.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class TestAllType_Enum extends $pb.ProtobufEnum {
  static const TestAllType_Enum ENUM_UNSPECIFIED = TestAllType_Enum._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ENUM_UNSPECIFIED');
  static const TestAllType_Enum ENUM_1 = TestAllType_Enum._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ENUM_1');
  static const TestAllType_Enum ENUM_2 = TestAllType_Enum._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ENUM_2');

  static const $core.List<TestAllType_Enum> values = <TestAllType_Enum> [
    ENUM_UNSPECIFIED,
    ENUM_1,
    ENUM_2,
  ];

  static final $core.Map<$core.int, TestAllType_Enum> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TestAllType_Enum? valueOf($core.int value) => _byValue[value];

  const TestAllType_Enum._($core.int v, $core.String n) : super(v, n);
}

