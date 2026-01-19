// This is a generated file - do not edit.
//
// Generated from packages.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class User extends $pb.GeneratedMessage {
  factory User({
    $core.int? id,
    $core.String? username,
    $core.String? password,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (username != null) result.username = username;
    if (password != null) result.password = password;
    return result;
  }

  User._();

  factory User.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory User.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'User',
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.Q3)
    ..aQS(2, _omitFieldNames ? '' : 'username')
    ..aQS(3, _omitFieldNames ? '' : 'password');

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User copyWith(void Function(User) updates) =>
      super.copyWith((message) => updates(message as User)) as User;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  @$core.override
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get password => $_getSZ(2);
  @$pb.TagNumber(3)
  set password($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPassword() => $_has(2);
  @$pb.TagNumber(3)
  void clearPassword() => $_clearField(3);
}

class Movie extends $pb.GeneratedMessage {
  factory Movie({
    $core.int? id,
    $core.String? title,
    $core.List<$core.int>? cover,
    $core.double? value,
    $core.String? year,
    $core.String? director,
    $core.String? sinopse,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (cover != null) result.cover = cover;
    if (value != null) result.value = value;
    if (year != null) result.year = year;
    if (director != null) result.director = director;
    if (sinopse != null) result.sinopse = sinopse;
    return result;
  }

  Movie._();

  factory Movie.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Movie.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Movie',
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.Q3)
    ..aQS(2, _omitFieldNames ? '' : 'title')
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'cover', $pb.PbFieldType.QY)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'value', $pb.PbFieldType.QF)
    ..aQS(5, _omitFieldNames ? '' : 'year')
    ..aQS(6, _omitFieldNames ? '' : 'director')
    ..aQS(7, _omitFieldNames ? '' : 'sinopse');

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Movie clone() => Movie()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Movie copyWith(void Function(Movie) updates) =>
      super.copyWith((message) => updates(message as Movie)) as Movie;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Movie create() => Movie._();
  @$core.override
  Movie createEmptyInstance() => create();
  static $pb.PbList<Movie> createRepeated() => $pb.PbList<Movie>();
  @$core.pragma('dart2js:noInline')
  static Movie getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Movie>(create);
  static Movie? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get cover => $_getN(2);
  @$pb.TagNumber(3)
  set cover($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCover() => $_has(2);
  @$pb.TagNumber(3)
  void clearCover() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get value => $_getN(3);
  @$pb.TagNumber(4)
  set value($core.double value) => $_setFloat(3, value);
  @$pb.TagNumber(4)
  $core.bool hasValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearValue() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get year => $_getSZ(4);
  @$pb.TagNumber(5)
  set year($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasYear() => $_has(4);
  @$pb.TagNumber(5)
  void clearYear() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get director => $_getSZ(5);
  @$pb.TagNumber(6)
  set director($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDirector() => $_has(5);
  @$pb.TagNumber(6)
  void clearDirector() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get sinopse => $_getSZ(6);
  @$pb.TagNumber(7)
  set sinopse($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSinopse() => $_has(6);
  @$pb.TagNumber(7)
  void clearSinopse() => $_clearField(7);
}

class Movies extends $pb.GeneratedMessage {
  factory Movies({
    $core.Iterable<Movie>? movies,
  }) {
    final result = create();
    if (movies != null) result.movies.addAll(movies);
    return result;
  }

  Movies._();

  factory Movies.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Movies.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Movies',
      createEmptyInstance: create)
    ..pc<Movie>(1, _omitFieldNames ? '' : 'movies', $pb.PbFieldType.PM,
        subBuilder: Movie.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Movies clone() => Movies()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Movies copyWith(void Function(Movies) updates) =>
      super.copyWith((message) => updates(message as Movies)) as Movies;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Movies create() => Movies._();
  @$core.override
  Movies createEmptyInstance() => create();
  static $pb.PbList<Movies> createRepeated() => $pb.PbList<Movies>();
  @$core.pragma('dart2js:noInline')
  static Movies getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Movies>(create);
  static Movies? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Movie> get movies => $_getList(0);
}

class Rental extends $pb.GeneratedMessage {
  factory Rental({
    $core.int? userId,
    $core.int? movieId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (movieId != null) result.movieId = movieId;
    return result;
  }

  Rental._();

  factory Rental.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Rental.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Rental',
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.Q3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'movieId', $pb.PbFieldType.Q3);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Rental clone() => Rental()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Rental copyWith(void Function(Rental) updates) =>
      super.copyWith((message) => updates(message as Rental)) as Rental;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Rental create() => Rental._();
  @$core.override
  Rental createEmptyInstance() => create();
  static $pb.PbList<Rental> createRepeated() => $pb.PbList<Rental>();
  @$core.pragma('dart2js:noInline')
  static Rental getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Rental>(create);
  static Rental? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get userId => $_getIZ(0);
  @$pb.TagNumber(1)
  set userId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get movieId => $_getIZ(1);
  @$pb.TagNumber(2)
  set movieId($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMovieId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMovieId() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
