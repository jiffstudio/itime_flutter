import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:itime_frontend/generated/l10n.dart';
import 'package:itime_frontend/models/index.dart';
import 'package:itime_frontend/res.dart';
import 'package:itime_frontend/styles/itime_colors.dart';
import 'package:itime_frontend/views/widgets/button.dart';
import 'package:itime_frontend/views/widgets/positioning_demo.dart';
import 'package:itime_frontend/views/widgets/text_field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:quiver/iterables.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../blocs/canteen/canteen_bloc.dart';
import '../blocs/settings/settings_bloc.dart';
import '../blocs/timetable/timetable_bloc.dart';
import '../model/splan/timetable_entry.dart';
import '../theme.dart';
import '../utils/date_utils.dart';
import 'additives.dart';
import 'settings/course_of_studies_settings.dart';
import 'settings/lecture_settings.dart';
import 'settings/semester_settings.dart';
import 'widgets/canteen.dart';
import 'widgets/date_selector.dart';
import 'widgets/list_header.dart';
import 'widgets/rounded_container.dart';
import 'widgets/timetable.dart';

class TimetablePage extends StatefulWidget {
  LoginResult result;

  TimetablePage(this.result);

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

extension StringToDuration on String {
  Duration toDuration() {
    DateTime dateTime = DateTime.parse(this);
    return Duration(hours: dateTime.hour, minutes: dateTime.minute);
  }
}

class _TimetablePageState extends State<TimetablePage>
    with SingleTickerProviderStateMixin {
  // PageView
  late PageController _pageController;
  int? _lastPage;

  late TabController _tabController;

  // 日期选择器
  late ValueKey _selectorKey;
  late DateTime _today;
  late DateTime _selectedDate;
  late DateTime _visibleWeekStart;

  late Iterable<num> _weekNumbers;

  int _selectedWeekIndex = 0;

  @override
  void initState() {
    super.initState();
    var now = DateTime.now().toUtc().withoutTime();

    // Jump to next week if it's saturday or sunday.
    if (now.weekday >= DateTime.saturday) {
      now = DateTime.now().weekStart().add(Duration(days: 7));
    }

    _selectorKey = ValueKey(now);
    _today = now;
    _selectedDate = now;
    _visibleWeekStart = now.weekStart();
    _weekNumbers = range(1, 11);

    _tabController = TabController(vsync: this, length: _weekNumbers.length);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<SettingsBloc, Settings>(
      builder: (context, settings) {
        return TimetableScaffold(
          actions: [
            GestureDetector(
              child: Image.asset(Res.search, width: 48),
              onTap: null,
            ),
            GestureDetector(
              child: Image.asset(Res.scan, width: 48),
              onTap: null,
            ),
            GestureDetector(
              child: Image.asset(Res.calendar, width: 48),
              onTap: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(24)), //加圆角
                  context: context,
                  builder: _buildTimetableModal,
                );
              },
            ),
            SizedBox(
              width: 8,
            ),
          ],
          title: _buildTitle(),
          positioningEvents: widget.result.arr
              .map((table) => table.events
                  .map((event) => event.time.map((time) => DemoEvent(
                      time.eventId,
                      time.eventTimeId,
                      time.startTime.toDuration(),
                      time.endTime.toDuration())))
                  .reduce((value, element) => value.toList()..addAll(element)))
              .reduce((value, element) => value.toList()..addAll(element))
              .toList(),
        );
      },
    );
  }

  Widget _buildTimetableModal(BuildContext context) {
    return _buildModal(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTimetableEntry("我的课表"),
          _buildTimetableEntry("我的蹭课表"),
          _buildTimetableEntry("我的计划表"),
          SizedBox(height: 8),
        ],
      ),
      title: "时间表",
      actions: [
        ImageButton(
          size: 48,
          image: Image.asset(Res.plus),
          onTap: () {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(24)), //加圆角
              context: context,
              builder: _buildCreateTimetableModal,
            );
          },
        ),
      ],
    );
  }

  Widget _buildCreateTimetableModal(BuildContext context) {
    return _buildModal(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineTextField(),
      ),
      title: "创建时间表",
      leading: ImageButton(
        size: 48,
        image: Image.asset(Res.cross),
        onTap: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(24)), //加圆角
            context: context,
            builder: _buildCreateTimetableModal,
          );
        },
      ),
      actions: [
        ImageButton(
          size: 48,
          image: Image.asset(Res.check),
          onTap: () {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(24)), //加圆角
              context: context,
              builder: _buildCreateTimetableModal,
            );
          },
        ),
      ],
    );
  }

  Widget _buildModal(
      {Widget? body,
      List<Widget>? actions,
      String title = "",
      Widget? leading}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            title: Text(title),
            centerTitle: true,
            leading: leading ?? Container(),
            toolbarHeight: 56,
            actions: [
              if (actions != null) ...actions,
              SizedBox(width: 12),
            ],
          ),
          if (body != null) body,
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 8,
        ),
        Expanded(
            child: Row(
          children: [
            Text('大三上学期', textAlign: TextAlign.left),
            SizedBox(width: 10),
            Image.asset(
              Res.arrow_drop_down,
              color: ItimeColors.black,
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildTimetableEntry(String name) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ItimeColors.vi,
            ),
            child: Padding(
                padding: EdgeInsets.all(18),
                child: Text(name,
                    style: textTheme.bodyText1!
                        .copyWith(color: ItimeColors.white))),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        ImageButton(size: 48, image: Image.asset(Res.refresh), onTap: null),
        ImageButton(size: 48, image: Image.asset(Res.share), onTap: null),
        ImageButton(size: 48, image: Image.asset(Res.edit), onTap: null),
        ImageButton(size: 48, image: Image.asset(Res.trash), onTap: null),
      ]),
    );
  }
}
