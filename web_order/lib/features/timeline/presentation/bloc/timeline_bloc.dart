import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/timeline_node.dart';

part 'timeline_bloc.freezed.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc({
    required List<TimelineNode> nodes,
  })  : _nodes = nodes,
        super(TimelineState.initial(nodes: nodes)) {
    on<_SelectTimelineNode>(_onSelect);
    on<_NextTimelineNode>(_onNext);
    on<_PreviousTimelineNode>(_onPrevious);
  }

  final List<TimelineNode> _nodes;

  void _onSelect(_SelectTimelineNode event, Emitter<TimelineState> emit) {
    final index = event.index.clamp(0, _nodes.length - 1);
    if (index == state.currentIndex) {
      return;
    }
    emit(state.copyWith(currentIndex: index));
  }

  void _onNext(_NextTimelineNode event, Emitter<TimelineState> emit) {
    final nextIndex = (state.currentIndex + 1) % _nodes.length;
    emit(state.copyWith(currentIndex: nextIndex));
  }

  void _onPrevious(
      _PreviousTimelineNode event, Emitter<TimelineState> emit) {
    final previousIndex =
        (state.currentIndex - 1 + _nodes.length) % _nodes.length;
    emit(state.copyWith(currentIndex: previousIndex));
  }
}

@freezed
class TimelineEvent with _$TimelineEvent {
  const factory TimelineEvent.select(int index) = _SelectTimelineNode;
  const factory TimelineEvent.next() = _NextTimelineNode;
  const factory TimelineEvent.previous() = _PreviousTimelineNode;
}

@freezed
class TimelineState with _$TimelineState {
  const factory TimelineState({
    required List<TimelineNode> nodes,
    required int currentIndex,
  }) = _TimelineState;

  factory TimelineState.initial({required List<TimelineNode> nodes}) =>
      TimelineState(
        nodes: nodes,
        currentIndex: 0,
      );
}
