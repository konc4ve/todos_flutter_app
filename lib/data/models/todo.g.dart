// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
  title: json['title'] as String,
  id: json['id'] as String?,
  status:
      $enumDecodeNullable(_$TodoStatusEnumMap, json['status']) ??
      TodoStatus.toBeCompleted,
  completionDate: DateTime.parse(json['completionDate'] as String),
);

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
  'title': instance.title,
  'id': instance.id,
  'completionDate': instance.completionDate.toIso8601String(),
  'status': _$TodoStatusEnumMap[instance.status]!,
};

const _$TodoStatusEnumMap = {
  TodoStatus.toBeCompleted: 'toBeCompleted',
  TodoStatus.inProgress: 'inProgress',
  TodoStatus.underReview: 'underReview',
  TodoStatus.completed: 'completed',
};
