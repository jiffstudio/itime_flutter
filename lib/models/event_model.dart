import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';

import 'time_model.dart';

@immutable
class EventModel {

  const EventModel({
    required this.eventId,
    required this.name,
    required this.location,
    required this.remarks,
    required this.tableId,
    required this.time,
    required this.termId,
  });

  final int eventId;
  final String name;
  final String location;
  final String remarks;
  final String tableId;
  final List<TimeModel> time;
  final String termId;

  factory EventModel.fromJson(Map<String,dynamic> json) => EventModel(
    eventId: json['eventId'] as int,
    name: json['name'] as String,
    location: json['location'] as String,
    remarks: json['remarks'] as String,
    tableId: json['tableId'] as String,
    time: (json['time'] as List? ?? []).map((e) => TimeModel.fromJson(e as Map<String, dynamic>)).toList(),
    termId: json['termId'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'eventId': eventId,
    'name': name,
    'location': location,
    'remarks': remarks,
    'tableId': tableId,
    'time': time.map((e) => e.toJson()).toList(),
    'termId': termId
  };

  EventModel clone() => EventModel(
    eventId: eventId,
    name: name,
    location: location,
    remarks: remarks,
    tableId: tableId,
    time: time.map((e) => e.clone()).toList(),
    termId: termId
  );


  EventModel copyWith({
    int? eventId,
    String? name,
    String? location,
    String? remarks,
    String? tableId,
    List<TimeModel>? time,
    String? termId
  }) => EventModel(
    eventId: eventId ?? this.eventId,
    name: name ?? this.name,
    location: location ?? this.location,
    remarks: remarks ?? this.remarks,
    tableId: tableId ?? this.tableId,
    time: time ?? this.time,
    termId: termId ?? this.termId,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is EventModel && eventId == other.eventId && name == other.name && location == other.location && remarks == other.remarks && tableId == other.tableId && time == other.time && termId == other.termId;

  @override
  int get hashCode => eventId.hashCode ^ name.hashCode ^ location.hashCode ^ remarks.hashCode ^ tableId.hashCode ^ time.hashCode ^ termId.hashCode;
}
