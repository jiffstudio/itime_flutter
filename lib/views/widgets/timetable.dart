import 'dart:math';

import 'package:flutter/material.dart';
import 'package:itime_frontend/styles/itime_colors.dart';
import 'package:itime_frontend/theme.dart';
import 'package:itime_frontend/views/widgets/positioning_demo.dart';
import 'package:itime_frontend/views/widgets/text_field.dart';
import 'package:quiver/iterables.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:timetable/timetable.dart';

import '../../model/splan/timetable_entry.dart';
import '../../res.dart';
import '../timetable/timetable_empty.dart';
import 'rounded_container.dart';
import 'timetable_entry_list_tile.dart';

import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:supercharged/supercharged.dart';

// class TimetableWidget extends StatelessWidget {
//   final DateTime selectedDate;
//   final List<TimetableEntry>? timetableEntries;
//
//   const TimetableWidget({
//     Key? key,
//     required this.selectedDate,
//     @required this.timetableEntries,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     if (timetableEntries == null) {
//       return RoundedContainer(
//         margin: EdgeInsets.symmetric(horizontal: 20),
//         child: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//     if (timetableEntries!.isEmpty) {
//       return TimetableNoLectures();
//     }
//
//     var combinedEntries = <List<TimetableEntry>>[];
//     var currentEntries = <TimetableEntry>[];
//
//     var lastTime;
//     for (final entry in timetableEntries!) {
//       if (entry.startTime == null || lastTime != entry.startTime) {
//         if (lastTime != null) {
//           combinedEntries.add(currentEntries);
//           currentEntries = <TimetableEntry>[];
//         }
//         lastTime = entry.startTime;
//       }
//
//       currentEntries.add(entry);
//     }
//
//     if (currentEntries != null && !currentEntries.isEmpty) {
//       combinedEntries.add(currentEntries);
//     }
//
//     return ListView.separated(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       itemCount: max(combinedEntries.length, 1),
//       itemBuilder: (context, index) {
//         return TimetableEntryListTile(
//           selectedDate: selectedDate,
//           entries: combinedEntries[index],
//         );
//       },
//       separatorBuilder: (context, index) => SizedBox(height: 12),
//     );
//   }
// }

class TimetableScaffold extends StatefulWidget {
  Widget? title;
  List<Widget>? actions;

  TimetableScaffold({this.title, this.actions});

  @override
  _TimetableScaffoldState createState() => _TimetableScaffoldState();
}

class _TimetableScaffoldState extends State<TimetableScaffold>
    with TickerProviderStateMixin {
  var _visibleDateRange = PredefinedVisibleDateRange.week;

  void _updateVisibleDateRange(PredefinedVisibleDateRange newValue) {
    setState(() {
      _visibleDateRange = newValue;
      _dateController.visibleRange = newValue.visibleDateRange;
    });
  }

  bool get _isRecurringLayout =>
      _visibleDateRange == PredefinedVisibleDateRange.fixed;

  late final _dateController = DateController(
    // All parameters are optional.
    // initialDate: DateTimeTimetable.today(),
    visibleRange: _visibleDateRange.visibleDateRange,
  );

  final _timeController = TimeController(
    // All parameters are optional.
    // initialRange: TimeRange(8.hours, 20.hours),
    maxRange: TimeRange(0.hours, 24.hours),
  );

  final _draggedEvents = <BasicEvent>[];

  late TabController _tabController;
  late Iterable<num> _weekNumbers;
  int _selectedWeekIndex = 0;

  @override
  void initState() {
    _weekNumbers = range(1, 11);
    _tabController = TabController(vsync: this, length: _weekNumbers.length);
    super.initState();
  }

  @override
  void dispose() {
    _timeController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildPartDayEvent(BasicEvent event) {
    final roundedTo = 15.minutes;

    return PartDayDraggableEvent(
      onDragStart: () => setState(() {
        _draggedEvents.add(event.copyWith(showOnTop: true));
      }),
      onDragUpdate: (dateTime) => setState(() {
        dateTime = dateTime.roundTimeToMultipleOf(roundedTo);
        final index = _draggedEvents.indexWhere((it) => it.id == event.id);
        final oldEvent = _draggedEvents[index];
        _draggedEvents[index] = oldEvent.copyWith(
          start: dateTime,
          end: dateTime + oldEvent.duration,
        );
      }),
      onDragEnd: (dateTime) {
        dateTime = (dateTime ?? event.start).roundTimeToMultipleOf(roundedTo);
        setState(() => _draggedEvents.removeWhere((it) => it.id == event.id));
        _showSnackBar('Dragged event to $dateTime.');
      },
      onDragCanceled: (isMoved) => _showSnackBar('Your finger moved: $isMoved'),
      child: BasicEventWidget(
        event,
        onTap: () => _showSnackBar('Part-day event $event tapped'),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      // backgroundColor: theme.primaryColorLight,
      toolbarHeight: 100,
      title: widget.title,
      actions: widget.actions,
      bottom: _buildTabBar(),
    );
    // final colorScheme = context.theme.colorScheme;
    // Widget child = AppBar(
    //   elevation: 0,
    //   titleTextStyle: TextStyle(color: colorScheme.onSurface),
    //   iconTheme: IconThemeData(color: colorScheme.onSurface),
    //   systemOverlayStyle: SystemUiOverlayStyle.light,
    //   backgroundColor: Colors.transparent,
    //   title: _isRecurringLayout
    //       ? null
    //       : MonthIndicator.forController(_dateController),
    //   actions: <Widget>[
    //     IconButton(
    //       icon: Icon(Icons.today),
    //       onPressed: () {
    //         _dateController.animateToToday(vsync: this);
    //         _timeController.animateToShowFullDay(vsync: this);
    //       },
    //       tooltip: 'Go to today',
    //     ),
    //     SizedBox(width: 8),
    //     DropdownButton<PredefinedVisibleDateRange>(
    //       onChanged: (visibleRange) => _updateVisibleDateRange(visibleRange!),
    //       value: _visibleDateRange,
    //       items: [
    //         for (final visibleRange in PredefinedVisibleDateRange.values)
    //           DropdownMenuItem(
    //             value: visibleRange,
    //             child: Text(visibleRange.title),
    //           ),
    //       ],
    //     ),
    //     SizedBox(width: 16),
    //   ],
    // );
    //
    // if (!_isRecurringLayout) {
    //   child = Column(children: [
    //     child,
    //     Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //       child: Builder(builder: (context) {
    //         return DefaultTimetableCallbacks(
    //           callbacks: DefaultTimetableCallbacks.of(context)!.copyWith(
    //             onDateTap: (date) {
    //               _showSnackBar('Tapped on date $date.');
    //               _updateVisibleDateRange(PredefinedVisibleDateRange.day);
    //               _dateController.animateTo(date, vsync: this);
    //             },
    //           ),
    //           child: CompactMonthTimetable(),
    //         );
    //       }),
    //     ),
    //   ]);
    // }
    //
    // return Material(color: colorScheme.surface, elevation: 4, child: child);
  }

  PreferredSizeWidget _buildTabBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(36),
      child: Material(
        color: ItimeColors.card,
        child: TabBar(
          onTap: (int i) {
            // TODO: 改成正常的日期
            var week = Week(2020, i + 21);
            _dateController.animateTo(
              week.getDayOfWeek(DateTime.monday),
              vsync: this,
            );
            setState(() {
              _selectedWeekIndex = i;
            });

          },
          physics: const BouncingScrollPhysics(),
          labelPadding: EdgeInsets.all(0),
          controller: _tabController,
          unselectedLabelColor: ItimeColors.normal,
          indicatorColor: Colors.green,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: double.minPositive,
          indicator: RectangularIndicator(
            topLeftRadius: 12,
            topRightRadius: 12,
            bottomLeftRadius: 12,
            bottomRightRadius: 12,
            color: ItimeColors.vi,
          ),
          isScrollable: true,
          tabs: _weekNumbers
              .map((i) =>
                  _buildWeekTab("第$i周", selected: i - 1 == _selectedWeekIndex))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildWeekTab(String title, {bool selected = false}) {
    return SizedBox(
        height: 36,
        child: Tab(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Text(
                  title,
                  style: textTheme.bodyText1!
                      .copyWith(color: selected ? ItimeColors.white : null),
                ))));
  }

  void _showSnackBar(String content) =>
      context.scaffoldMessenger.showSnackBar(SnackBar(content: Text(content)));

  Widget _buildBody() {
    return TimetableConfig<BasicEvent>(
      // Required:
      dateController: _dateController,
      timeController: _timeController,
      eventBuilder: (context, event) => _buildPartDayEvent(event),
      child: MultiDateTimetable<BasicEvent>(),
      // Optional:
      eventProvider: eventProviderFromFixedList(positioningDemoEvents),
      allDayEventBuilder: (context, event, info) => BasicAllDayEventWidget(
        event,
        info: info,
        onTap: () => _showSnackBar('All-day event $event tapped'),
      ),
      timeOverlayProvider: mergeTimeOverlayProviders([
        positioningDemoOverlayProvider,
        (context, date) => _draggedEvents
            .map((it) =>
                it.toTimeOverlay(date: date, widget: BasicEventWidget(it)))
            .whereNotNull()
            .toList(),
      ]),
      callbacks: TimetableCallbacks(
        onWeekTap: (week) {
          _showSnackBar('Tapped on week $week.');
          _updateVisibleDateRange(PredefinedVisibleDateRange.week);
          _dateController.animateTo(
            week.getDayOfWeek(DateTime.monday),
            vsync: this,
          );
        },
        onDateTap: (date) {
          _showSnackBar('Tapped on date $date.');
          _dateController.animateTo(date, vsync: this);
        },
        onDateBackgroundTap: (date) =>
            _showSnackBar('Tapped on date background at $date.'),
        onDateTimeBackgroundTap: (dateTime) =>
            _showSnackBar('Tapped on date-time background at $dateTime.'),
      ),
      theme: TimetableThemeData(
        context,
        dateIndicatorStyleProvider: (date) {
          final today = DateTimeTimetable.today();
          final isToday = date == today;
          final baseTextStyle =
              textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w500);

          return DateIndicatorStyle(context, date,
              decoration: BoxDecoration(),
              textStyle: isToday
                  ? baseTextStyle.copyWith(
                      color: ItimeColors.vi,
                    )
                  : baseTextStyle);
        },
        weekdayIndicatorStyleProvider: (date) {
          final today = DateTimeTimetable.today();
          final isToday = date == today;
          final baseTextStyle =
              textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w500);
          return WeekdayIndicatorStyle(context, date,
              textStyle: isToday
                  ? baseTextStyle.copyWith(
                      color: ItimeColors.vi,
                      fontWeight: FontWeight.w700,
                    )
                  : baseTextStyle);
        },
        dateHeaderStyleProvider: (date) {
          return DateHeaderStyle(
            context,
            date,
            indicatorSpacing: 0,
          );
        },
        weekIndicatorStyleProvider: (week) {
          // TODO: 修改成正常的时间
          return WeekIndicatorStyle(
              context, Week(week.weekBasedYear, week.weekOfYear - 20));
        },
        // startOfWeek: DateTime.monday,
        // dateDividersStyle: DateDividersStyle(
        //   context,
        //   color: Colors.blue.withOpacity(.3),
        //   width: 2,
        // ),
        // nowIndicatorStyle: NowIndicatorStyle(
        //   context,
        //   lineColor: Colors.green,
        //   shape: TriangleNowIndicatorShape(color: Colors.green),
        // ),
        timeIndicatorStyleProvider: (time) => TimeIndicatorStyle(
          context,
          time,
          alwaysUse24HourFormat: true,
        ),
      ),
    );
  }
}

enum PredefinedVisibleDateRange { day, threeDays, workWeek, week, fixed }

extension on PredefinedVisibleDateRange {
  VisibleDateRange get visibleDateRange {
    switch (this) {
      case PredefinedVisibleDateRange.day:
        return VisibleDateRange.days(1);
      case PredefinedVisibleDateRange.threeDays:
        return VisibleDateRange.days(3);
      case PredefinedVisibleDateRange.workWeek:
        return VisibleDateRange.weekAligned(5);
      case PredefinedVisibleDateRange.week:
        return VisibleDateRange.week();
      case PredefinedVisibleDateRange.fixed:
        return VisibleDateRange.fixed(
          DateTimeTimetable.today(),
          DateTime.daysPerWeek,
        );
    }
  }

  String get title {
    switch (this) {
      case PredefinedVisibleDateRange.day:
        return 'Day';
      case PredefinedVisibleDateRange.threeDays:
        return '3 Days';
      case PredefinedVisibleDateRange.workWeek:
        return 'Work Week';
      case PredefinedVisibleDateRange.week:
        return 'Week';
      case PredefinedVisibleDateRange.fixed:
        return '7 Days (fixed)';
    }
  }
}
