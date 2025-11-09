// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimelineNodeImpl _$$TimelineNodeImplFromJson(Map<String, dynamic> json) =>
    _$TimelineNodeImpl(
      year: (json['year'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$$TimelineNodeImplToJson(_$TimelineNodeImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
    };
