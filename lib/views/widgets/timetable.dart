import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itime_frontend/styles/itime_colors.dart';
import 'package:itime_frontend/theme.dart';
import 'package:itime_frontend/views/widgets/positioning_demo.dart';
import 'package:itime_frontend/views/widgets/tab_view.dart';
import 'package:itime_frontend/views/widgets/term.dart';
import 'package:itime_frontend/views/widgets/term_week.dart';
import 'package:quiver/iterables.dart';
import 'package:supercharged/supercharged.dart';
import 'package:timetable/src/utils/listenable.dart';
import 'package:timetable/timetable.dart';

class TimetableScaffold extends StatefulWidget {
  Widget? title;
  List<Widget>? actions;
  List<BasicEvent> positioningEvents;

  TimetableScaffold(
      {this.title, this.actions, required this.positioningEvents});

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
    initialDate: DateTimeTimetable.today(),
    visibleRange: _visibleDateRange.visibleDateRange,
  );

  final _timeController = TimeController(
    // All parameters are optional.
    // initialRange: TimeRange(8.hours, 20.hours),
    maxRange: TimeRange(0.hours, 24.hours),
  );

  final _draggedEvents = <BasicEvent>[];

  late Iterable<num> _weekNumbers;

  @override
  void initState() {
    _weekNumbers = range(1, 11);
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
    return TimetableConfig<BasicEvent>(
      // Required:
      dateController: _dateController,
      timeController: _timeController,
      eventBuilder: (context, event) => _buildPartDayEvent(event),
      child: _buildScaffold(),
      // Optional:
      eventProvider: eventProviderFromFixedList(widget.positioningEvents),
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

          return DateIndicatorStyle(context, date,
              decoration: BoxDecoration(),
              textStyle: isToday
                  ? textTheme.tinyBold!.copyWith(
                      color: ItimeColors.vi,
                    )
                  : textTheme.tiny!,
              padding: EdgeInsets.all(3));
        },
        weekdayIndicatorStyleProvider: (date) {
          final today = DateTimeTimetable.today();
          final isToday = date == today;
          return WeekdayIndicatorStyle(context, date,
              textStyle: isToday
                  ? textTheme.normalSmallHeavy!.copyWith(
                      color: ItimeColors.vi,
                    )
                  : textTheme.normalSmallBold);
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
          print(Term.byWeek(week));
          return WeekIndicatorStyle(context, week);
        },
        // startOfWeek: DateTime.tuesday,
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
        child: ValueListenableBuilder<TermWeek>(
          valueListenable: _dateController.map((it) =>
              DateTimeTimetable.dateFromPage(
                      (it.page + it.visibleDayCount / 2).floor())
                  .termWeek),
          builder: (context, termWeek, _) => TabView(
            initPosition: DateTime.now().termWeek.weekOfTerm - 1,
            position: termWeek.weekOfTerm - 1,
            itemCount: termWeek.weekBasedTerm.weeks,
            onTap: (index) {
              int weekOfTerm = termWeek.weekBasedTerm.weeksOfTerm[index];
              var week = Term.byDate(DateTime.now()).obtainWeek(weekOfTerm);
              _dateController.animateTo(
                week.getDayOfWeek(DateTime.monday),
                vsync: this,
              );
            },
            tabBuilder: (context, index) {
              int weekOfTerm = termWeek.weekBasedTerm.weeksOfTerm[index];
              return _buildWeekTab(weekOfTerm,
                  selected: weekOfTerm == termWeek.weekOfTerm);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWeekTab(int weekOfTerm, {bool selected = false}) {
    return SizedBox(
        height: 36,
        child: Tab(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 200),
                  style: textTheme.normalBold!
                      .copyWith(color: selected ? ItimeColors.white : null),
                  child: Text(
                    "第$weekOfTerm周",
                  ),
                ))));
  }

  void _showSnackBar(String content) =>
      context.scaffoldMessenger.showSnackBar(SnackBar(content: Text(content)));

  Widget _buildBody() {
    return MultiDateTimetable<BasicEvent>();
  }

  Widget _buildScaffold() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: _buildBody(),
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

extension WeekX on Week {
  static Week forSemester(DateTime date, DateTime base) {
    assert(date.isValidTimetableDate);

    final year = base.year;
    final weekOfYear = (date.dayOfYear - base.dayOfYear) ~/ 7 + 1;

    return Week(year, weekOfYear);
  }

  Week rebase(DateTime base) {
    final year = base.year;
    final newWeekOfYear = weekOfYear - base.week.weekOfYear + 1;
    assert(newWeekOfYear >= 1);
    return Week(year, newWeekOfYear);
  }

  Week nextOrSame(int nextWeeks) {
    return Week(weekBasedYear, weekOfYear + nextWeeks);
  }

  Duration difference(Week other) {
    return getDayOfWeek(1).difference(other.getDayOfWeek(1));
  }
}

extension WeekDuration on Duration {
  int get inWeeks => inDays ~/ 7;
}

extension TermDate on DateTime {
  TermWeek get termWeek {
    Term weekBasedTerm = Term.byDate(this);
    int weekOfTerm = this.week.difference(weekBasedTerm).inWeeks + 1;
    return TermWeek(weekBasedTerm, weekOfTerm);
  }
}
