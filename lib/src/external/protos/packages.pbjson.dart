// This is a generated file - do not edit.
//
// Generated from packages.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 2, '5': 5, '10': 'id'},
    {'1': 'username', '3': 2, '4': 2, '5': 9, '10': 'username'},
    {'1': 'password', '3': 3, '4': 2, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgAigFUgJpZBIaCgh1c2VybmFtZRgCIAIoCVIIdXNlcm5hbWUSGgoIcG'
    'Fzc3dvcmQYAyACKAlSCHBhc3N3b3Jk');

@$core.Deprecated('Use movieDescriptor instead')
const Movie$json = {
  '1': 'Movie',
  '2': [
    {'1': 'id', '3': 1, '4': 2, '5': 5, '10': 'id'},
    {'1': 'title', '3': 2, '4': 2, '5': 9, '10': 'title'},
    {'1': 'cover', '3': 3, '4': 2, '5': 12, '10': 'cover'},
    {'1': 'value', '3': 4, '4': 2, '5': 2, '10': 'value'},
    {'1': 'year', '3': 5, '4': 2, '5': 9, '10': 'year'},
    {'1': 'director', '3': 6, '4': 2, '5': 9, '10': 'director'},
    {'1': 'sinopse', '3': 7, '4': 2, '5': 9, '10': 'sinopse'},
  ],
};

/// Descriptor for `Movie`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List movieDescriptor = $convert.base64Decode(
    'CgVNb3ZpZRIOCgJpZBgBIAIoBVICaWQSFAoFdGl0bGUYAiACKAlSBXRpdGxlEhQKBWNvdmVyGA'
    'MgAigMUgVjb3ZlchIUCgV2YWx1ZRgEIAIoAlIFdmFsdWUSEgoEeWVhchgFIAIoCVIEeWVhchIa'
    'CghkaXJlY3RvchgGIAIoCVIIZGlyZWN0b3ISGAoHc2lub3BzZRgHIAIoCVIHc2lub3BzZQ==');

@$core.Deprecated('Use moviesDescriptor instead')
const Movies$json = {
  '1': 'Movies',
  '2': [
    {'1': 'movies', '3': 1, '4': 3, '5': 11, '6': '.Movie', '10': 'movies'},
  ],
};

/// Descriptor for `Movies`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moviesDescriptor = $convert
    .base64Decode('CgZNb3ZpZXMSHgoGbW92aWVzGAEgAygLMgYuTW92aWVSBm1vdmllcw==');

@$core.Deprecated('Use rentalDescriptor instead')
const Rental$json = {
  '1': 'Rental',
  '2': [
    {'1': 'user_id', '3': 1, '4': 2, '5': 5, '10': 'userId'},
    {'1': 'movie_id', '3': 2, '4': 2, '5': 5, '10': 'movieId'},
  ],
};

/// Descriptor for `Rental`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rentalDescriptor = $convert.base64Decode(
    'CgZSZW50YWwSFwoHdXNlcl9pZBgBIAIoBVIGdXNlcklkEhkKCG1vdmllX2lkGAIgAigFUgdtb3'
    'ZpZUlk');
