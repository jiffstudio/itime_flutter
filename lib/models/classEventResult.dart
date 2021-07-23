import 'package:flutter/foundation.dart';
import 'classTimeResult.dart';

@immutable
class ClassEventResult {

  const ClassEventResult({
    required this.eventId,
    required this.name,
    required this.location,
    required this.tableId,
    required this.colorId,
    required this.time,
  });

  final int eventId;
  final String name;
  final String location;
  final String tableId;
  final int colorId;
  final List<ClassTimeResult> time;

  factory ClassEventResult.fromJson(Map<String,dynamic> json) => ClassEventResult(
    eventId: json['eventId'] as int,
    name: json['name'] as String,
    location: json['location'] as String,
    tableId: json['tableId'] as String,
    colorId: json['colorId'] as int,
    time: (json['time'] as List? ?? []).map((e) => ClassTimeResult.fromJson(e)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'eventId': eventId,
    'name': name,
    'location': location,
    'tableId': tableId,
    'colorId': colorId,
    'time': time.map((e) => e.toString()).toList()
  };

  ClassEventResult clone() => ClassEventResult(
    eventId: eventId,
    name: name,
    location: location,
    tableId: tableId,
    colorId: colorId,
    time: time.toList()
  );


  ClassEventResult copyWith({
    int? eventId,
    String? name,
    String? location,
    String? tableId,
    int? colorId,
    List<ClassTimeResult>? time
  }) => ClassEventResult(
    eventId: eventId ?? this.eventId,
    name: name ?? this.name,
    location: location ?? this.location,
    tableId: tableId ?? this.tableId,
    colorId: colorId ?? this.colorId,
    time: time ?? this.time,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is ClassEventResult && eventId == other.eventId && name == other.name && location == other.location && tableId == other.tableId && colorId == other.colorId && time == other.time;

  @override
  int get hashCode => eventId.hashCode ^ name.hashCode ^ location.hashCode ^ tableId.hashCode ^ colorId.hashCode ^ time.hashCode;
}
