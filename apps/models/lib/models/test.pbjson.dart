///
//  Generated code. Do not modify.
//  source: models/test.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use testAllTypeDescriptor instead')
const TestAllType$json = const {
  '1': 'TestAllType',
  '2': const [
    const {'1': 'bool', '3': 1, '4': 1, '5': 8, '10': 'bool'},
    const {'1': 'bytes', '3': 2, '4': 1, '5': 12, '10': 'bytes'},
    const {'1': 'double', '3': 3, '4': 1, '5': 1, '10': 'double'},
    const {'1': 'fixed32', '3': 4, '4': 1, '5': 7, '10': 'fixed32'},
    const {'1': 'fixed64', '3': 5, '4': 1, '5': 6, '10': 'fixed64'},
    const {'1': 'float', '3': 6, '4': 1, '5': 2, '10': 'float'},
    const {'1': 'int32', '3': 7, '4': 1, '5': 5, '10': 'int32'},
    const {'1': 'int64', '3': 8, '4': 1, '5': 3, '10': 'int64'},
    const {'1': 'map_bool_string', '3': 9, '4': 3, '5': 11, '6': '.TestAllType.MapBoolStringEntry', '10': 'mapBoolString'},
    const {'1': 'sint32', '3': 10, '4': 1, '5': 17, '10': 'sint32'},
    const {'1': 'sint64', '3': 11, '4': 1, '5': 18, '10': 'sint64'},
    const {'1': 'sfixed32', '3': 12, '4': 1, '5': 15, '10': 'sfixed32'},
    const {'1': 'sfixed64', '3': 13, '4': 1, '5': 16, '10': 'sfixed64'},
    const {'1': 'string', '3': 14, '4': 1, '5': 9, '10': 'string'},
    const {'1': 'uint32', '3': 15, '4': 1, '5': 13, '10': 'uint32'},
    const {'1': 'uint64', '3': 16, '4': 1, '5': 4, '10': 'uint64'},
    const {'1': 'repeated_doubles', '3': 17, '4': 3, '5': 1, '10': 'repeatedDoubles'},
    const {'1': 'message', '3': 18, '4': 1, '5': 11, '6': '.TestAllType.Message', '10': 'message'},
    const {'1': 'enum', '3': 19, '4': 1, '5': 14, '6': '.TestAllType.Enum', '10': 'enum'},
    const {'1': 'oneof_int32', '3': 20, '4': 1, '5': 5, '9': 0, '10': 'oneofInt32'},
    const {'1': 'oneof_int64', '3': 21, '4': 1, '5': 3, '9': 0, '10': 'oneofInt64'},
    const {'1': 'oneof_string', '3': 22, '4': 1, '5': 9, '9': 0, '10': 'oneofString'},
    const {'1': 'id', '3': 23, '4': 1, '5': 9, '10': 'id'},
  ],
  '3': const [TestAllType_MapBoolStringEntry$json, TestAllType_Message$json],
  '4': const [TestAllType_Enum$json],
  '8': const [
    const {'1': 'oneof_value'},
  ],
};

@$core.Deprecated('Use testAllTypeDescriptor instead')
const TestAllType_MapBoolStringEntry$json = const {
  '1': 'MapBoolStringEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 8, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

@$core.Deprecated('Use testAllTypeDescriptor instead')
const TestAllType_Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'string', '3': 1, '4': 1, '5': 9, '10': 'string'},
    const {'1': 'uint32', '3': 2, '4': 1, '5': 13, '10': 'uint32'},
  ],
};

@$core.Deprecated('Use testAllTypeDescriptor instead')
const TestAllType_Enum$json = const {
  '1': 'Enum',
  '2': const [
    const {'1': 'ENUM_UNSPECIFIED', '2': 0},
    const {'1': 'ENUM_1', '2': 1},
    const {'1': 'ENUM_2', '2': 2},
  ],
};

/// Descriptor for `TestAllType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testAllTypeDescriptor = $convert.base64Decode('CgtUZXN0QWxsVHlwZRISCgRib29sGAEgASgIUgRib29sEhQKBWJ5dGVzGAIgASgMUgVieXRlcxIWCgZkb3VibGUYAyABKAFSBmRvdWJsZRIYCgdmaXhlZDMyGAQgASgHUgdmaXhlZDMyEhgKB2ZpeGVkNjQYBSABKAZSB2ZpeGVkNjQSFAoFZmxvYXQYBiABKAJSBWZsb2F0EhQKBWludDMyGAcgASgFUgVpbnQzMhIUCgVpbnQ2NBgIIAEoA1IFaW50NjQSRwoPbWFwX2Jvb2xfc3RyaW5nGAkgAygLMh8uVGVzdEFsbFR5cGUuTWFwQm9vbFN0cmluZ0VudHJ5Ug1tYXBCb29sU3RyaW5nEhYKBnNpbnQzMhgKIAEoEVIGc2ludDMyEhYKBnNpbnQ2NBgLIAEoElIGc2ludDY0EhoKCHNmaXhlZDMyGAwgASgPUghzZml4ZWQzMhIaCghzZml4ZWQ2NBgNIAEoEFIIc2ZpeGVkNjQSFgoGc3RyaW5nGA4gASgJUgZzdHJpbmcSFgoGdWludDMyGA8gASgNUgZ1aW50MzISFgoGdWludDY0GBAgASgEUgZ1aW50NjQSKQoQcmVwZWF0ZWRfZG91YmxlcxgRIAMoAVIPcmVwZWF0ZWREb3VibGVzEi4KB21lc3NhZ2UYEiABKAsyFC5UZXN0QWxsVHlwZS5NZXNzYWdlUgdtZXNzYWdlEiUKBGVudW0YEyABKA4yES5UZXN0QWxsVHlwZS5FbnVtUgRlbnVtEiEKC29uZW9mX2ludDMyGBQgASgFSABSCm9uZW9mSW50MzISIQoLb25lb2ZfaW50NjQYFSABKANIAFIKb25lb2ZJbnQ2NBIjCgxvbmVvZl9zdHJpbmcYFiABKAlIAFILb25lb2ZTdHJpbmcSDgoCaWQYFyABKAlSAmlkGkAKEk1hcEJvb2xTdHJpbmdFbnRyeRIQCgNrZXkYASABKAhSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBGjkKB01lc3NhZ2USFgoGc3RyaW5nGAEgASgJUgZzdHJpbmcSFgoGdWludDMyGAIgASgNUgZ1aW50MzIiNAoERW51bRIUChBFTlVNX1VOU1BFQ0lGSUVEEAASCgoGRU5VTV8xEAESCgoGRU5VTV8yEAJCDQoLb25lb2ZfdmFsdWU=');
