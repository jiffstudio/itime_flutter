import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itime_frontend/generated/l10n.dart';

import '../../blocs/settings/settings_bloc.dart';
import '../../data/splan_api.dart';
import 'course_of_studies_settings.dart';
import 'semester_settings.dart';

class LectureSettings extends StatefulWidget {
  @override
  _LectureSettingsState createState() => _LectureSettingsState();
}

class _LectureSettingsState extends State<LectureSettings> {
  final int maxLectures = 35;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool initialized = false;
  late List<PlanningGroup> planningGroups;

  int? selectedTotal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(S.of(context).settings_lectures_title),
        actions: <Widget>[
          if (selectedTotal != null)
            Padding(
              padding: EdgeInsets.only(right: 12, top: 20),
              child: Text(
                '$selectedTotal/$maxLectures',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ),
        ],
      ),
      body: BlocBuilder<SettingsBloc, Settings>(
        builder: (context, settings) {
          if (settings.initialized) {
            if (settings.semester == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(S.of(context)
                        .settings_semester_not_configured),
                    RaisedButton(
                      child: Text(S.of(context)
                          .settings_semester_not_configured_button),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SemesterSettings(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            if (settings.course == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      S.of(context).settings_course_not_configured,
                    ),
                    RaisedButton(
                      child: Text(S.of(context)
                          .settings_course_not_configured_button),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseOfStudiesSettings(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            // Load Planning Groups on first render
            if (!initialized) {
              SplanApi()
                  .getPlanningGroupsForSemesterAndCourse(
                      semester: settings.semester!, course: settings.course!)
                  .then((value) {
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  setState(() {
                    initialized = true;
                    planningGroups = value!;
                    selectedTotal = settings.lectures!.length;
                  });
                });
              });
            }

            if (initialized) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                itemCount: planningGroups.length,
                itemBuilder: (context, index) {
                  final planningGroup = planningGroups[index];

                  var selected = 0;
                  for (final lecture in settings.lectures!) {
                    if (planningGroup.lectures.contains(lecture)) {
                      selected++;
                    }
                  }

                  return Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: ExpansionTile(
                        title: Text(
                          '${planningGroup.shortName} '
                          '($selected/${planningGroup.lectures.length})',
                        ),
                        subtitle: Text(planningGroup.name),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                  child: Text(
                                    S.of(context)
                                        .settings_lectures_deselect_all,
                                  ),
                                  onPressed: () {
                                    final lectures = [...?settings.lectures];
                                    var removed = lectures.length;
                                    lectures.removeWhere(
                                        planningGroup.lectures.contains);
                                    setState(() {
                                      selectedTotal ??= selectedTotal! -
                                          removed - lectures.length;
                                    });
                                    BlocProvider.of<SettingsBloc>(context)
                                        .add(Settings(lectures: lectures));
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    S.of(context)
                                        .settings_lectures_select_all,
                                  ),
                                  onPressed: () {
                                    final notSelected = [
                                      ...planningGroup.lectures
                                    ]
                                        .where((lecture) => !settings.lectures!
                                            .contains(lecture))
                                        .toList();

                                    if (selectedTotal! + notSelected.length >
                                        maxLectures) {
                                      _scaffoldKey.currentState!.showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            S.of(context)
                                                .settings_lectures_max,
                                          ),
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        selectedTotal ??= selectedTotal! + notSelected.length;
                                      });
                                      BlocProvider.of<SettingsBloc>(context)
                                          .add(
                                        Settings(
                                          lectures: [
                                            ...?settings.lectures,
                                            ...notSelected
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          for (final lecture in planningGroup.lectures)
                            CheckboxListTile(
                              title: Text(lecture.shortName),
                              subtitle: Text(lecture.name),
                              value: settings.lectures!.contains(lecture),
                              onChanged: (checked) {
                                final lectures = [...?settings.lectures];

                                if (checked! && !lectures.contains(lecture)) {
                                  if (selectedTotal != maxLectures) {
                                    lectures.add(lecture);
                                    setState(() {
                                      selectedTotal ??= selectedTotal! + 1;
                                    });
                                  } else {
                                    _scaffoldKey.currentState!.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          S.of(context)
                                              .settings_lectures_max,
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  lectures.remove(lecture);
                                  setState(() {
                                    selectedTotal ??= selectedTotal?? - 1;
                                  });
                                }
                                BlocProvider.of<SettingsBloc>(context).add(
                                  Settings(lectures: lectures),
                                );
                              },
                            )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 4),
              );
            }
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _CourseTile extends StatefulWidget {
  final Course course;

  const _CourseTile({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  __CourseTileState createState() => __CourseTileState();
}

class __CourseTileState extends State<_CourseTile> {
  Course get course => widget.course;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(course.name),
      children: <Widget>[],
    );
  }
}
