// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeline_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TimelineEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index) select,
    required TResult Function() next,
    required TResult Function() previous,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int index)? select,
    TResult? Function()? next,
    TResult? Function()? previous,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int index)? select,
    TResult Function()? next,
    TResult Function()? previous,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectTimelineNode value) select,
    required TResult Function(_NextTimelineNode value) next,
    required TResult Function(_PreviousTimelineNode value) previous,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SelectTimelineNode value)? select,
    TResult? Function(_NextTimelineNode value)? next,
    TResult? Function(_PreviousTimelineNode value)? previous,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectTimelineNode value)? select,
    TResult Function(_NextTimelineNode value)? next,
    TResult Function(_PreviousTimelineNode value)? previous,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineEventCopyWith<$Res> {
  factory $TimelineEventCopyWith(
          TimelineEvent value, $Res Function(TimelineEvent) then) =
      _$TimelineEventCopyWithImpl<$Res, TimelineEvent>;
}

/// @nodoc
class _$TimelineEventCopyWithImpl<$Res, $Val extends TimelineEvent>
    implements $TimelineEventCopyWith<$Res> {
  _$TimelineEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SelectTimelineNodeImplCopyWith<$Res> {
  factory _$$SelectTimelineNodeImplCopyWith(_$SelectTimelineNodeImpl value,
          $Res Function(_$SelectTimelineNodeImpl) then) =
      __$$SelectTimelineNodeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$SelectTimelineNodeImplCopyWithImpl<$Res>
    extends _$TimelineEventCopyWithImpl<$Res, _$SelectTimelineNodeImpl>
    implements _$$SelectTimelineNodeImplCopyWith<$Res> {
  __$$SelectTimelineNodeImplCopyWithImpl(_$SelectTimelineNodeImpl _value,
      $Res Function(_$SelectTimelineNodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$SelectTimelineNodeImpl(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SelectTimelineNodeImpl implements _SelectTimelineNode {
  const _$SelectTimelineNodeImpl(this.index);

  @override
  final int index;

  @override
  String toString() {
    return 'TimelineEvent.select(index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectTimelineNodeImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectTimelineNodeImplCopyWith<_$SelectTimelineNodeImpl> get copyWith =>
      __$$SelectTimelineNodeImplCopyWithImpl<_$SelectTimelineNodeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index) select,
    required TResult Function() next,
    required TResult Function() previous,
  }) {
    return select(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int index)? select,
    TResult? Function()? next,
    TResult? Function()? previous,
  }) {
    return select?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int index)? select,
    TResult Function()? next,
    TResult Function()? previous,
    required TResult orElse(),
  }) {
    if (select != null) {
      return select(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectTimelineNode value) select,
    required TResult Function(_NextTimelineNode value) next,
    required TResult Function(_PreviousTimelineNode value) previous,
  }) {
    return select(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SelectTimelineNode value)? select,
    TResult? Function(_NextTimelineNode value)? next,
    TResult? Function(_PreviousTimelineNode value)? previous,
  }) {
    return select?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectTimelineNode value)? select,
    TResult Function(_NextTimelineNode value)? next,
    TResult Function(_PreviousTimelineNode value)? previous,
    required TResult orElse(),
  }) {
    if (select != null) {
      return select(this);
    }
    return orElse();
  }
}

abstract class _SelectTimelineNode implements TimelineEvent {
  const factory _SelectTimelineNode(final int index) = _$SelectTimelineNodeImpl;

  int get index;

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectTimelineNodeImplCopyWith<_$SelectTimelineNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NextTimelineNodeImplCopyWith<$Res> {
  factory _$$NextTimelineNodeImplCopyWith(_$NextTimelineNodeImpl value,
          $Res Function(_$NextTimelineNodeImpl) then) =
      __$$NextTimelineNodeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NextTimelineNodeImplCopyWithImpl<$Res>
    extends _$TimelineEventCopyWithImpl<$Res, _$NextTimelineNodeImpl>
    implements _$$NextTimelineNodeImplCopyWith<$Res> {
  __$$NextTimelineNodeImplCopyWithImpl(_$NextTimelineNodeImpl _value,
      $Res Function(_$NextTimelineNodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NextTimelineNodeImpl implements _NextTimelineNode {
  const _$NextTimelineNodeImpl();

  @override
  String toString() {
    return 'TimelineEvent.next()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NextTimelineNodeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index) select,
    required TResult Function() next,
    required TResult Function() previous,
  }) {
    return next();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int index)? select,
    TResult? Function()? next,
    TResult? Function()? previous,
  }) {
    return next?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int index)? select,
    TResult Function()? next,
    TResult Function()? previous,
    required TResult orElse(),
  }) {
    if (next != null) {
      return next();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectTimelineNode value) select,
    required TResult Function(_NextTimelineNode value) next,
    required TResult Function(_PreviousTimelineNode value) previous,
  }) {
    return next(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SelectTimelineNode value)? select,
    TResult? Function(_NextTimelineNode value)? next,
    TResult? Function(_PreviousTimelineNode value)? previous,
  }) {
    return next?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectTimelineNode value)? select,
    TResult Function(_NextTimelineNode value)? next,
    TResult Function(_PreviousTimelineNode value)? previous,
    required TResult orElse(),
  }) {
    if (next != null) {
      return next(this);
    }
    return orElse();
  }
}

abstract class _NextTimelineNode implements TimelineEvent {
  const factory _NextTimelineNode() = _$NextTimelineNodeImpl;
}

/// @nodoc
abstract class _$$PreviousTimelineNodeImplCopyWith<$Res> {
  factory _$$PreviousTimelineNodeImplCopyWith(_$PreviousTimelineNodeImpl value,
          $Res Function(_$PreviousTimelineNodeImpl) then) =
      __$$PreviousTimelineNodeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PreviousTimelineNodeImplCopyWithImpl<$Res>
    extends _$TimelineEventCopyWithImpl<$Res, _$PreviousTimelineNodeImpl>
    implements _$$PreviousTimelineNodeImplCopyWith<$Res> {
  __$$PreviousTimelineNodeImplCopyWithImpl(_$PreviousTimelineNodeImpl _value,
      $Res Function(_$PreviousTimelineNodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PreviousTimelineNodeImpl implements _PreviousTimelineNode {
  const _$PreviousTimelineNodeImpl();

  @override
  String toString() {
    return 'TimelineEvent.previous()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreviousTimelineNodeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int index) select,
    required TResult Function() next,
    required TResult Function() previous,
  }) {
    return previous();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int index)? select,
    TResult? Function()? next,
    TResult? Function()? previous,
  }) {
    return previous?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int index)? select,
    TResult Function()? next,
    TResult Function()? previous,
    required TResult orElse(),
  }) {
    if (previous != null) {
      return previous();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SelectTimelineNode value) select,
    required TResult Function(_NextTimelineNode value) next,
    required TResult Function(_PreviousTimelineNode value) previous,
  }) {
    return previous(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SelectTimelineNode value)? select,
    TResult? Function(_NextTimelineNode value)? next,
    TResult? Function(_PreviousTimelineNode value)? previous,
  }) {
    return previous?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SelectTimelineNode value)? select,
    TResult Function(_NextTimelineNode value)? next,
    TResult Function(_PreviousTimelineNode value)? previous,
    required TResult orElse(),
  }) {
    if (previous != null) {
      return previous(this);
    }
    return orElse();
  }
}

abstract class _PreviousTimelineNode implements TimelineEvent {
  const factory _PreviousTimelineNode() = _$PreviousTimelineNodeImpl;
}

/// @nodoc
mixin _$TimelineState {
  List<TimelineNode> get nodes => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimelineStateCopyWith<TimelineState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineStateCopyWith<$Res> {
  factory $TimelineStateCopyWith(
          TimelineState value, $Res Function(TimelineState) then) =
      _$TimelineStateCopyWithImpl<$Res, TimelineState>;
  @useResult
  $Res call({List<TimelineNode> nodes, int currentIndex});
}

/// @nodoc
class _$TimelineStateCopyWithImpl<$Res, $Val extends TimelineState>
    implements $TimelineStateCopyWith<$Res> {
  _$TimelineStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? currentIndex = null,
  }) {
    return _then(_value.copyWith(
      nodes: null == nodes
          ? _value.nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<TimelineNode>,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimelineStateImplCopyWith<$Res>
    implements $TimelineStateCopyWith<$Res> {
  factory _$$TimelineStateImplCopyWith(
          _$TimelineStateImpl value, $Res Function(_$TimelineStateImpl) then) =
      __$$TimelineStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TimelineNode> nodes, int currentIndex});
}

/// @nodoc
class __$$TimelineStateImplCopyWithImpl<$Res>
    extends _$TimelineStateCopyWithImpl<$Res, _$TimelineStateImpl>
    implements _$$TimelineStateImplCopyWith<$Res> {
  __$$TimelineStateImplCopyWithImpl(
      _$TimelineStateImpl _value, $Res Function(_$TimelineStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? currentIndex = null,
  }) {
    return _then(_$TimelineStateImpl(
      nodes: null == nodes
          ? _value._nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<TimelineNode>,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TimelineStateImpl implements _TimelineState {
  const _$TimelineStateImpl(
      {required final List<TimelineNode> nodes, required this.currentIndex})
      : _nodes = nodes;

  final List<TimelineNode> _nodes;
  @override
  List<TimelineNode> get nodes {
    if (_nodes is EqualUnmodifiableListView) return _nodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nodes);
  }

  @override
  final int currentIndex;

  @override
  String toString() {
    return 'TimelineState(nodes: $nodes, currentIndex: $currentIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelineStateImpl &&
            const DeepCollectionEquality().equals(other._nodes, _nodes) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_nodes), currentIndex);

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelineStateImplCopyWith<_$TimelineStateImpl> get copyWith =>
      __$$TimelineStateImplCopyWithImpl<_$TimelineStateImpl>(this, _$identity);
}

abstract class _TimelineState implements TimelineState {
  const factory _TimelineState(
      {required final List<TimelineNode> nodes,
      required final int currentIndex}) = _$TimelineStateImpl;

  @override
  List<TimelineNode> get nodes;
  @override
  int get currentIndex;

  /// Create a copy of TimelineState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimelineStateImplCopyWith<_$TimelineStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
