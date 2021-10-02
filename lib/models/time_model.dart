import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';



@immutable
class TimeModel {

  const TimeModel({
    required this.eventTimeId,
    required this.eventId,
    this.startTime,
    this.endTime,
    required this.week,
    required this.day,
    required this.absoluteDate,
  });

  final int eventTimeId;
  final int eventId;
  final String? startTime;
  final String? endTime;
  final int week;
  final int day;
  final DateTime absoluteDate;

  factory TimeModel.fromJson(Map<String,dynamic> json) => TimeModel(
    eventTimeId: json['eventTimeId'] as int,
    eventId: json['eventId'] as int,
    startTime: json['startTime'] != null ? json['startTime'] as String : null,
    endTime: json['endTime'] != null ? json['endTime'] as String : null,
    week: json['week'] as int,
    day: json['day'] as int,
    absoluteDate: DateTime.parse(json['absoluteDate'] as String)
  );
  
  Map<String, dynamic> toJson() => {
    'eventTimeId': eventTimeId,
    'eventId': eventId,
    'startTime': startTime,
    'endTime': endTime,
    'week': week,
    'day': day,
    'absoluteDate': absoluteDate.toIso8601String()
  };

  TimeModel clone() => TimeModel(
    eventTimeId: eventTimeId,
    eventId: eventId,
    startTime: startTime,
    endTime: endTime,
    week: week,
    day: day,
    absoluteDate: absoluteDate
  );


  TimeModel copyWith({
    int? eventTimeId,
    int? eventId,
    Optional<String?>? startTime,
    Optional<String?>? endTime,
    int? week,
    int? day,
    DateTime? absoluteDate
  }) => TimeModel(
    eventTimeId: eventTimeId ?? this.eventTimeId,
    eventId: eventId ?? this.eventId,
    startTime: checkOptional(startTime, this.startTime),
    endTime: checkOptional(endTime, this.endTime),
    week: week ?? this.week,
    day: day ?? this.day,
    absoluteDate: absoluteDate ?? this.absoluteDate,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is TimeModel && eventTimeId == other.eventTimeId && eventId == other.eventId && startTime == other.startTime && endTime == other.endTime && week == other.week && day == other.day && absoluteDate == other.absoluteDate;

  @override
  int get hashCode => eventTimeId.hashCode ^ eventId.hashCode ^ startTime.hashCode ^ endTime.hashCode ^ week.hashCode ^ day.hashCode ^ absoluteDate.hashCode;
}
