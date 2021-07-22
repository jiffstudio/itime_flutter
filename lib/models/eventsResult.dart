import 'package:flutter/foundation.dart';
import 'timeResult.dart';

@immutable
class EventsResult {

  const EventsResult({
    required this.eventId,
    required this.name,
    required this.location,
    required this.remarks,
    required this.tableId,
    required this.colorId,
    required this.time,
    required this.eventType,
  });

  final int eventId;
  final String name;
  final String location;
  final String remarks;
  final String tableId;
  final dynamic colorId;
  final List<TimeResult> time;
  final dynamic eventType;

  factory EventsResult.fromJson(Map<String,dynamic> json) => EventsResult(
    eventId: json['eventId'] as int,
    name: json['name'] as String,
    location: json['location'] as String,
    remarks: json['remarks'] as String,
    tableId: json['tableId'] as String,
    colorId: json['colorId'] as dynamic,
    time: (json['time'] as List? ?? []).map((e) => TimeResult.fromJson(e)).toList(),
    eventType: json['eventType'] as dynamic
  );
  
  Map<String, dynamic> toJson() => {
    'eventId': eventId,
    'name': name,
    'location': location,
    'remarks': remarks,
    'tableId': tableId,
    'colorId': colorId,
    'time': time.map((e) => e.toString()).toList(),
    'eventType': eventType
  };

  EventsResult clone() => EventsResult(
    eventId: eventId,
    name: name,
    location: location,
    remarks: remarks,
    tableId: tableId,
    colorId: colorId,
    time: time.toList(),
    eventType: eventType
  );


  EventsResult copyWith({
    int? eventId,
    String? name,
    String? location,
    String? remarks,
    String? tableId,
    dynamic? colorId,
    List<TimeResult>? time,
    dynamic? eventType
  }) => EventsResult(
    eventId: eventId ?? this.eventId,
    name: name ?? this.name,
    location: location ?? this.location,
    remarks: remarks ?? this.remarks,
    tableId: tableId ?? this.tableId,
    colorId: colorId ?? this.colorId,
    time: time ?? this.time,
    eventType: eventType ?? this.eventType,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is EventsResult && eventId == other.eventId && name == other.name && location == other.location && remarks == other.remarks && tableId == other.tableId && colorId == other.colorId && time == other.time && eventType == other.eventType;

  @override
  int get hashCode => eventId.hashCode ^ name.hashCode ^ location.hashCode ^ remarks.hashCode ^ tableId.hashCode ^ colorId.hashCode ^ time.hashCode ^ eventType.hashCode;
}
