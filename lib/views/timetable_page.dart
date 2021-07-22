import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:itime_frontend/generated/l10n.dart';
import 'package:itime_frontend/res.dart';
import 'package:itime_frontend/styles/itime_colors.dart';
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
  @override
  _TimetablePageState createState() => _TimetablePageState();
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
            Image.asset(R.search, width: 48),
            Image.asset(R.scan, width: 48),
            Image.asset(R.calendar, width: 48),
            SizedBox(
              width: 8,
            ),
          ],
          title: _buildTitle(),
        );
      },
    );
  }

  Widget _buildTitle(){
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
                  R.arrow_drop_down,
                  color: ItimeColors.black,
                ),
              ],
            )),
      ],
    );
  }

}
