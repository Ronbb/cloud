///
//  Generated code. Do not modify.
//  source: models/test.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'test.pbenum.dart';

export 'test.pbenum.dart';

class TestAllType_Message extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TestAllType.Message', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'string')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uint32', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  TestAllType_Message._() : super();
  factory TestAllType_Message({
    $core.String? string,
    $core.int? uint32,
  }) {
    final _result = create();
    if (string != null) {
      _result.string = string;
    }
    if (uint32 != null) {
      _result.uint32 = uint32;
    }
    return _result;
  }
  factory TestAllType_Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TestAllType_Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TestAllType_Message clone() => TestAllType_Message()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TestAllType_Message copyWith(void Function(TestAllType_Message) updates) => super.copyWith((message) => updates(message as TestAllType_Message)) as TestAllType_Message; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TestAllType_Message create() => TestAllType_Message._();
  TestAllType_Message createEmptyInstance() => create();
  static $pb.PbList<TestAllType_Message> createRepeated() => $pb.PbList<TestAllType_Message>();
  @$core.pragma('dart2js:noInline')
  static TestAllType_Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TestAllType_Message>(create);
  static TestAllType_Message? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get string => $_getSZ(0);
  @$pb.TagNumber(1)
  set string($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasString() => $_has(0);
  @$pb.TagNumber(1)
  void clearString() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get uint32 => $_getIZ(1);
  @$pb.TagNumber(2)
  set uint32($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUint32() => $_has(1);
  @$pb.TagNumber(2)
  void clearUint32() => clearField(2);
}

enum TestAllType_OneofValue {
  oneofInt32, 
  oneofInt64, 
  oneofString, 
  notSet
}

class TestAllType extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, TestAllType_OneofValue> _TestAllType_OneofValueByTag = {
    20 : TestAllType_OneofValue.oneofInt32,
    21 : TestAllType_OneofValue.oneofInt64,
    22 : TestAllType_OneofValue.oneofString,
    0 : TestAllType_OneofValue.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TestAllType', createEmptyInstance: create)
    ..oo(0, [20, 21, 22])
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bool')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bytes', $pb.PbFieldType.OY)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'double', $pb.PbFieldType.OD)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixed32', $pb.PbFieldType.OF3)
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixed64', $pb.PbFieldType.OF6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'float', $pb.PbFieldType.OF)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'int32', $pb.PbFieldType.O3)
    ..aInt64(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'int64')
    ..m<$core.bool, $core.String>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mapBoolString', entryClassName: 'TestAllType.MapBoolStringEntry', keyFieldType: $pb.PbFieldType.OB, valueFieldType: $pb.PbFieldType.OS)
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sint32', $pb.PbFieldType.OS3)
    ..a<$fixnum.Int64>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sint64', $pb.PbFieldType.OS6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sfixed32', $pb.PbFieldType.OSF3)
    ..a<$fixnum.Int64>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sfixed64', $pb.PbFieldType.OSF6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'string')
    ..a<$core.int>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uint32', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uint64', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..p<$core.double>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'repeatedDoubles', $pb.PbFieldType.PD)
    ..aOM<TestAllType_Message>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message', subBuilder: TestAllType_Message.create)
    ..e<TestAllType_Enum>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enum', $pb.PbFieldType.OE, defaultOrMaker: TestAllType_Enum.ENUM_UNSPECIFIED, valueOf: TestAllType_Enum.valueOf, enumValues: TestAllType_Enum.values)
    ..a<$core.int>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'oneofInt32', $pb.PbFieldType.O3)
    ..aInt64(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'oneofInt64')
    ..aOS(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'oneofString')
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  TestAllType._() : super();
  factory TestAllType({
    $core.bool? bool_1,
    $core.List<$core.int>? bytes,
    $core.double? double_3,
    $core.int? fixed32,
    $fixnum.Int64? fixed64,
    $core.double? float,
    $core.int? int32,
    $fixnum.Int64? int64,
    $core.Map<$core.bool, $core.String>? mapBoolString,
    $core.int? sint32,
    $fixnum.Int64? sint64,
    $core.int? sfixed32,
    $fixnum.Int64? sfixed64,
    $core.String? string,
    $core.int? uint32,
    $fixnum.Int64? uint64,
    $core.Iterable<$core.double>? repeatedDoubles,
    TestAllType_Message? message,
    TestAllType_Enum? enum_19,
    $core.int? oneofInt32,
    $fixnum.Int64? oneofInt64,
    $core.String? oneofString,
    $core.String? id,
  }) {
    final _result = create();
    if (bool_1 != null) {
      _result.bool_1 = bool_1;
    }
    if (bytes != null) {
      _result.bytes = bytes;
    }
    if (double_3 != null) {
      _result.double_3 = double_3;
    }
    if (fixed32 != null) {
      _result.fixed32 = fixed32;
    }
    if (fixed64 != null) {
      _result.fixed64 = fixed64;
    }
    if (float != null) {
      _result.float = float;
    }
    if (int32 != null) {
      _result.int32 = int32;
    }
    if (int64 != null) {
      _result.int64 = int64;
    }
    if (mapBoolString != null) {
      _result.mapBoolString.addAll(mapBoolString);
    }
    if (sint32 != null) {
      _result.sint32 = sint32;
    }
    if (sint64 != null) {
      _result.sint64 = sint64;
    }
    if (sfixed32 != null) {
      _result.sfixed32 = sfixed32;
    }
    if (sfixed64 != null) {
      _result.sfixed64 = sfixed64;
    }
    if (string != null) {
      _result.string = string;
    }
    if (uint32 != null) {
      _result.uint32 = uint32;
    }
    if (uint64 != null) {
      _result.uint64 = uint64;
    }
    if (repeatedDoubles != null) {
      _result.repeatedDoubles.addAll(repeatedDoubles);
    }
    if (message != null) {
      _result.message = message;
    }
    if (enum_19 != null) {
      _result.enum_19 = enum_19;
    }
    if (oneofInt32 != null) {
      _result.oneofInt32 = oneofInt32;
    }
    if (oneofInt64 != null) {
      _result.oneofInt64 = oneofInt64;
    }
    if (oneofString != null) {
      _result.oneofString = oneofString;
    }
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory TestAllType.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TestAllType.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TestAllType clone() => TestAllType()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TestAllType copyWith(void Function(TestAllType) updates) => super.copyWith((message) => updates(message as TestAllType)) as TestAllType; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TestAllType create() => TestAllType._();
  TestAllType createEmptyInstance() => create();
  static $pb.PbList<TestAllType> createRepeated() => $pb.PbList<TestAllType>();
  @$core.pragma('dart2js:noInline')
  static TestAllType getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TestAllType>(create);
  static TestAllType? _defaultInstance;

  TestAllType_OneofValue whichOneofValue() => _TestAllType_OneofValueByTag[$_whichOneof(0)]!;
  void clearOneofValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.bool get bool_1 => $_getBF(0);
  @$pb.TagNumber(1)
  set bool_1($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBool_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearBool_1() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get bytes => $_getN(1);
  @$pb.TagNumber(2)
  set bytes($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBytes() => $_has(1);
  @$pb.TagNumber(2)
  void clearBytes() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get double_3 => $_getN(2);
  @$pb.TagNumber(3)
  set double_3($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDouble_3() => $_has(2);
  @$pb.TagNumber(3)
  void clearDouble_3() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get fixed32 => $_getIZ(3);
  @$pb.TagNumber(4)
  set fixed32($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFixed32() => $_has(3);
  @$pb.TagNumber(4)
  void clearFixed32() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get fixed64 => $_getI64(4);
  @$pb.TagNumber(5)
  set fixed64($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFixed64() => $_has(4);
  @$pb.TagNumber(5)
  void clearFixed64() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get float => $_getN(5);
  @$pb.TagNumber(6)
  set float($core.double v) { $_setFloat(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFloat() => $_has(5);
  @$pb.TagNumber(6)
  void clearFloat() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get int32 => $_getIZ(6);
  @$pb.TagNumber(7)
  set int32($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasInt32() => $_has(6);
  @$pb.TagNumber(7)
  void clearInt32() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get int64 => $_getI64(7);
  @$pb.TagNumber(8)
  set int64($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasInt64() => $_has(7);
  @$pb.TagNumber(8)
  void clearInt64() => clearField(8);

  @$pb.TagNumber(9)
  $core.Map<$core.bool, $core.String> get mapBoolString => $_getMap(8);

  @$pb.TagNumber(10)
  $core.int get sint32 => $_getIZ(9);
  @$pb.TagNumber(10)
  set sint32($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasSint32() => $_has(9);
  @$pb.TagNumber(10)
  void clearSint32() => clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get sint64 => $_getI64(10);
  @$pb.TagNumber(11)
  set sint64($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSint64() => $_has(10);
  @$pb.TagNumber(11)
  void clearSint64() => clearField(11);

  @$pb.TagNumber(12)
  $core.int get sfixed32 => $_getIZ(11);
  @$pb.TagNumber(12)
  set sfixed32($core.int v) { $_setSignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasSfixed32() => $_has(11);
  @$pb.TagNumber(12)
  void clearSfixed32() => clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get sfixed64 => $_getI64(12);
  @$pb.TagNumber(13)
  set sfixed64($fixnum.Int64 v) { $_setInt64(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasSfixed64() => $_has(12);
  @$pb.TagNumber(13)
  void clearSfixed64() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get string => $_getSZ(13);
  @$pb.TagNumber(14)
  set string($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasString() => $_has(13);
  @$pb.TagNumber(14)
  void clearString() => clearField(14);

  @$pb.TagNumber(15)
  $core.int get uint32 => $_getIZ(14);
  @$pb.TagNumber(15)
  set uint32($core.int v) { $_setUnsignedInt32(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasUint32() => $_has(14);
  @$pb.TagNumber(15)
  void clearUint32() => clearField(15);

  @$pb.TagNumber(16)
  $fixnum.Int64 get uint64 => $_getI64(15);
  @$pb.TagNumber(16)
  set uint64($fixnum.Int64 v) { $_setInt64(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasUint64() => $_has(15);
  @$pb.TagNumber(16)
  void clearUint64() => clearField(16);

  @$pb.TagNumber(17)
  $core.List<$core.double> get repeatedDoubles => $_getList(16);

  @$pb.TagNumber(18)
  TestAllType_Message get message => $_getN(17);
  @$pb.TagNumber(18)
  set message(TestAllType_Message v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasMessage() => $_has(17);
  @$pb.TagNumber(18)
  void clearMessage() => clearField(18);
  @$pb.TagNumber(18)
  TestAllType_Message ensureMessage() => $_ensure(17);

  @$pb.TagNumber(19)
  TestAllType_Enum get enum_19 => $_getN(18);
  @$pb.TagNumber(19)
  set enum_19(TestAllType_Enum v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasEnum_19() => $_has(18);
  @$pb.TagNumber(19)
  void clearEnum_19() => clearField(19);

  @$pb.TagNumber(20)
  $core.int get oneofInt32 => $_getIZ(19);
  @$pb.TagNumber(20)
  set oneofInt32($core.int v) { $_setSignedInt32(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasOneofInt32() => $_has(19);
  @$pb.TagNumber(20)
  void clearOneofInt32() => clearField(20);

  @$pb.TagNumber(21)
  $fixnum.Int64 get oneofInt64 => $_getI64(20);
  @$pb.TagNumber(21)
  set oneofInt64($fixnum.Int64 v) { $_setInt64(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasOneofInt64() => $_has(20);
  @$pb.TagNumber(21)
  void clearOneofInt64() => clearField(21);

  @$pb.TagNumber(22)
  $core.String get oneofString => $_getSZ(21);
  @$pb.TagNumber(22)
  set oneofString($core.String v) { $_setString(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasOneofString() => $_has(21);
  @$pb.TagNumber(22)
  void clearOneofString() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get id => $_getSZ(22);
  @$pb.TagNumber(23)
  set id($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasId() => $_has(22);
  @$pb.TagNumber(23)
  void clearId() => clearField(23);
}

