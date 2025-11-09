// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeline_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimelineNode _$TimelineNodeFromJson(Map<String, dynamic> json) {
  return _TimelineNode.fromJson(json);
}

/// @nodoc
mixin _$TimelineNode {
  int get year => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  /// Serializes this TimelineNode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimelineNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimelineNodeCopyWith<TimelineNode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineNodeCopyWith<$Res> {
  factory $TimelineNodeCopyWith(
          TimelineNode value, $Res Function(TimelineNode) then) =
      _$TimelineNodeCopyWithImpl<$Res, TimelineNode>;
  @useResult
  $Res call({int year, String title, String description, String image});
}

/// @nodoc
class _$TimelineNodeCopyWithImpl<$Res, $Val extends TimelineNode>
    implements $TimelineNodeCopyWith<$Res> {
  _$TimelineNodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimelineNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? title = null,
    Object? description = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimelineNodeImplCopyWith<$Res>
    implements $TimelineNodeCopyWith<$Res> {
  factory _$$TimelineNodeImplCopyWith(
          _$TimelineNodeImpl value, $Res Function(_$TimelineNodeImpl) then) =
      __$$TimelineNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int year, String title, String description, String image});
}

/// @nodoc
class __$$TimelineNodeImplCopyWithImpl<$Res>
    extends _$TimelineNodeCopyWithImpl<$Res, _$TimelineNodeImpl>
    implements _$$TimelineNodeImplCopyWith<$Res> {
  __$$TimelineNodeImplCopyWithImpl(
      _$TimelineNodeImpl _value, $Res Function(_$TimelineNodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? title = null,
    Object? description = null,
    Object? image = null,
  }) {
    return _then(_$TimelineNodeImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimelineNodeImpl implements _TimelineNode {
  const _$TimelineNodeImpl(
      {required this.year,
      required this.title,
      required this.description,
      required this.image});

  factory _$TimelineNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimelineNodeImplFromJson(json);

  @override
  final int year;
  @override
  final String title;
  @override
  final String description;
  @override
  final String image;

  @override
  String toString() {
    return 'TimelineNode(year: $year, title: $title, description: $description, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelineNodeImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, year, title, description, image);

  /// Create a copy of TimelineNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelineNodeImplCopyWith<_$TimelineNodeImpl> get copyWith =>
      __$$TimelineNodeImplCopyWithImpl<_$TimelineNodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimelineNodeImplToJson(
      this,
    );
  }
}

abstract class _TimelineNode implements TimelineNode {
  const factory _TimelineNode(
      {required final int year,
      required final String title,
      required final String description,
      required final String image}) = _$TimelineNodeImpl;

  factory _TimelineNode.fromJson(Map<String, dynamic> json) =
      _$TimelineNodeImpl.fromJson;

  @override
  int get year;
  @override
  String get title;
  @override
  String get description;
  @override
  String get image;

  /// Create a copy of TimelineNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimelineNodeImplCopyWith<_$TimelineNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
