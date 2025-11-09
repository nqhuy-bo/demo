import 'package:freezed_annotation/freezed_annotation.dart';

part 'timeline_node.freezed.dart';
part 'timeline_node.g.dart';

@freezed
class TimelineNode with _$TimelineNode {
  const factory TimelineNode({
    required int year,
    required String title,
    required String description,
    required String image,
  }) = _TimelineNode;

  factory TimelineNode.fromJson(Map<String, dynamic> json) =>
      _$TimelineNodeFromJson(json);
}
