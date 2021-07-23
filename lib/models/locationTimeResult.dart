import 'package:flutter/foundation.dart';


@immutable
class LocationTimeResult {

  const LocationTimeResult({
    required this.eventTimeId,
    required this.eventId,
    required this.startTime,
    required this.endTime,
    required this.week,
    required this.day,
  });

  final int eventTimeId;
  final int eventId;
  final String startTime;
  final String endTime;
  final int week;
  final int day;

  factory LocationTimeResult.fromJson(Map<String,dynamic> json) => LocationTimeResult(
    eventTimeId: json['eventTimeId'] as int,
    eventId: json['eventId'] as int,
    startTime: json['startTime'] as String,
    endTime: json['endTime'] as String,
    week: json['week'] as int,
    day: json['day'] as int
  );
  
  Map<String, dynamic> toJson() => {
    'eventTimeId': eventTimeId,
    'eventId': eventId,
    'startTime': startTime,
    'endTime': endTime,
    'week': week,
    'day': day
  };

  LocationTimeResult clone() => LocationTimeResult(
    eventTimeId: eventTimeId,
    eventId: eventId,
    startTime: startTime,
    endTime: endTime,
    week: week,
    day: day
  );


  LocationTimeResult copyWith({
    int? eventTimeId,
    int? eventId,
    String? startTime,
    String? endTime,
    int? week,
    int? day
  }) => LocationTimeResult(
    eventTimeId: eventTimeId ?? this.eventTimeId,
    eventId: eventId ?? this.eventId,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    week: week ?? this.week,
    day: day ?? this.day,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is LocationTimeResult && eventTimeId == other.eventTimeId && eventId == other.eventId && startTime == other.startTime && endTime == other.endTime && week == other.week && day == other.day;

  @override
  int get hashCode => eventTimeId.hashCode ^ eventId.hashCode ^ startTime.hashCode ^ endTime.hashCode ^ week.hashCode ^ day.hashCode;
}
