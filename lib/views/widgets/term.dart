import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/timetable.dart';

@immutable
class Term extends Week {
  static List<Term> _terms = [];
  static final _fallback = Term(1949, 1, termId: "", weeks: 0, name: "����");
  final String termId;
  final String name;
  final int weeks;
  final List<int> weeksOfTerm;

  static set terms(List<Term> terms) {
    _terms = terms;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(
          'terms', json.encode(_terms.map((term) => term.toJson()).toList()));
    });
  }

  static load() async {
    final prefs = await SharedPreferences.getInstance();
    _terms = (json.decode(prefs.getString('terms') ?? '[]') as List)
        .map((e) => Term.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Term byId(String termId) {
    return _terms.firstWhere((term) => term.termId == termId,
        orElse: () => _fallback);
  }

  factory Term.fromJson(Map<String, dynamic> json) => Term(
        json['weekBasedYear'] as int,
        json['weekOfYear'] as int,
        termId: json['termId'] as String,
        weeks: json['weeks'] as int,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'weekBasedYear': weekBasedYear,
        'weekOfYear': weekOfYear,
        'termId': termId,
        'weeks': weeks
      };

  Term(int weekBasedYear, int weekOfYear,
      {required this.termId, required this.weeks, required this.name})
      : weeksOfTerm = List.generate(weeks, (index) => index + 1),
        super(weekBasedYear, weekOfYear);

  Term.fromWeek(Week week, {required this.termId, required this.weeks, required this.name})
      : weeksOfTerm = List.generate(weeks, (index) => index + 1),
        super(week.weekBasedYear, week.weekOfYear);

  factory Term.byDate(DateTime date) {
    date = date.atStartOfDay;
    var week = Week.forDate(date);
    var term = _terms.lastWhere((term) {
      return week.compareTo(term) >= 0;
    }, orElse: () => _fallback);
    return term;
  }

  factory Term.byWeek(Week week) {
    var term = _terms.lastWhere((term) => week.compareTo(term) >= 0,
        orElse: () => _fallback);
    return term;
  }

  Week obtainWeek(int weekOfTerm) {
    return Week(weekBasedYear, weekOfYear + weekOfTerm - 1);
  }

  DateTime get startDate {
    return getDayOfWeek(1);
  }

  @override
  String toString() {
    return '${super.toString()}: ${getDayOfWeek(1)}';
  }
}
