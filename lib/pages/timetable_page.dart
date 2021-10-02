import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:itime_frontend/blocs/share/share_bloc.dart';
import 'package:itime_frontend/blocs/timetable/timetable_bloc.dart';
import 'package:itime_frontend/models/table_member_model.dart';
import 'package:itime_frontend/models/timetable_model.dart';
import 'package:itime_frontend/res.dart';
import 'package:itime_frontend/styles/itime_colors.dart';
import 'package:itime_frontend/views/widgets/button.dart';
import 'package:itime_frontend/views/widgets/custom_card.dart';
import 'package:itime_frontend/views/widgets/popup_menu.dart';
import 'package:itime_frontend/views/widgets/text_field.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quiver/iterables.dart';

import '../theme.dart';
import '../utils/date_utils.dart';
import '../views/widgets/timetable.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage();

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const TimetablePage());
  }

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
  final TextEditingController _createTableNameController =
      TextEditingController();

  @override
  void dispose() {
    _createTableNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();

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
    return BlocBuilder<TimetableBloc, TimetableState>(
      builder: (context, state) {
        switch (state.load) {
          case LoadTimetableStatus.success:
            return TimetableScaffold(
              actions: [
                _buildSearch(),
                _buildScan(),
                _buildCalendar(),
                SizedBox(
                  width: 8,
                ),
              ],
              title: _buildTitle(),
              positioningEvents: state.events,
            );
          case LoadTimetableStatus.loading:
            return Center(
              child: CircularProgressIndicator(
                color: ItimeColors.vi,
              ),
            );
          case LoadTimetableStatus.initial:
            context.read<TimetableBloc>().add(LoadTimetable());
            return Container();
          case LoadTimetableStatus.failure:
            return Text("获取失败！");
        }
      },
    );
  }

  Widget _buildManageTimetableModal(BuildContext context) {
    return _buildModal(
      body: BlocBuilder<TimetableBloc, TimetableState>(
        builder: (context, state) {
          return state.load == LoadTimetableStatus.success
              ? StaggeredGridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  physics: NeverScrollableScrollPhysics(),
                  staggeredTiles: List.generate(
                      state.timetables.length, (_) => StaggeredTile.fit(1)),
                  children: state.timetables.map((table) {
                    bool select = state.isSelected[table.tableId] ?? true;
                    return FlatCard.toggle(
                      title: table.tableName,
                      subtitle: table.tableName,
                      color: ItimeColors.card,
                      selectedColor: ItimeColors.vi,
                      select: select,
                      onTap: () => context.read<TimetableBloc>().add(
                          ReverseTimetableSelect(timetableId: table.tableId)),
                      items: [
                        OverlayMenuItem(
                          child: Text("查看"),
                          // value: "dota",
                        ),
                        OverlayMenuItem(
                          child: Text("分享"),
                          value: () =>
                              _showShareTimetableModal(timetable: table),
                        ),
                        OverlayMenuItem(
                          child: Text("删除"),
                          value: DeleteTimetable(timetableId: table.tableId),
                        ),
                      ],
                      onSelected: (value) {
                        if (value is TimetableEvent)
                          context.read<TimetableBloc>().add(value);
                        else if (value is Function) value();
                      },
                    );
                  }).toList(),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: ItimeColors.vi,
                  ),
                );
        },
      ),
      title: "显示 / 隐藏时间表",
      actions: [
        _buildCreate(),
      ],
    );
  }

  Widget _buildCreateTimetableModal(BuildContext context) {
    return _buildModal(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        child: ItimeTextField(
          autofocus: true,
          controller: _createTableNameController,
        ),
      ),
      title: "创建时间表",
      leading: ImageButton(
        size: 48,
        image: Image.asset(Res.cross),
        onTap: () {
          context.read<TimetableBloc>().add(CompleteCreateTimetable());
          Navigator.pop(context);
        },
      ),
      actions: [
        BlocBuilder<TimetableBloc, TimetableState>(builder: (context, state) {
          switch (state.create) {
            case CreateTimetableStatus.initial:
            case CreateTimetableStatus.failure:
              return ImageButton(
                size: 48,
                image: Image.asset(Res.check),
                onTap: () {
                  context.read<TimetableBloc>().add(CreateTimetable(
                      timetableName: _createTableNameController.text));
                },
              );
            case CreateTimetableStatus.loading:
              return CircularProgressIndicator(color: ItimeColors.vi);
            case CreateTimetableStatus.success:
              context.read<TimetableBloc>().add(CompleteCreateTimetable());
              Navigator.pop(context);
              return Container();
          }
        }),
      ],
    );
  }

  Widget _buildShareTimetableModal({required TimetableModel timetable}) {
    return BlocProvider(
      create: (context) => ShareBloc(),
      child: _buildModal(
        title: '共享"${timetable.tableName}"',
        body: BlocBuilder<ShareBloc, ShareState>(
          builder: (context, state) {
            if (state.load == LoadShareStatus.initial)
              context
                  .read<ShareBloc>()
                  .add(LoadShare(tableId: timetable.tableId));

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                state.shareId != null
                    ? QrImage(
                        data: state.shareId!,
                        size: 160,
                        foregroundColor: ItimeColors.qr,
                        eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square),
                      )
                    : CircularProgressIndicator(color: ItimeColors.vi),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShareContainer(
                          child: _buildShareEntry(
                              title: "扫描二维码的人", readOnly: true)),
                      if (state.members != null) ...[
                        SizedBox(height: 32),
                        Text(
                          "已加入",
                          style: textTheme.headline6,
                        ),
                        SizedBox(height: 20),
                        _buildShareContainer(
                          child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.members!.length,
                            itemBuilder: (context, index) => _buildMemberEntry(
                                member: state.members![index]),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16.0),
                          ),
                        ),
                      ],
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildShareContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ItimeColors.card,
      ),
      child: child,
    );
  }

  Row _buildShareEntry({required String title, required bool readOnly}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.headline6,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              readOnly ? "可查看" : "可编辑",
              style: TextStyle(
                color: Color(0xff686868),
                fontSize: 16,
                letterSpacing: 0.16,
              ),
            ),
            SizedBox(width: 4),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: FlutterLogo(size: 12),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildMemberEntry({required TableMemberModel member}) {
    return _buildShareEntry(title: member.userName, readOnly: member.readOnly);
  }

  Widget _buildModal(
      {Widget? body,
      List<Widget>? actions,
      String title = "",
      Widget? leading}) {
    return LayoutBuilder(builder: (context, constraints) {
      return ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(24),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
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
              Flexible(
                child: LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: AnimatedContainer(
                      padding: MediaQuery.of(context).viewInsets,
                      duration: const Duration(milliseconds: 100),
                      child: body,
                    ),
                  );
                }),
              ),
            ],
          );
        }),
      );
    });
  }

  Widget _buildTitle() {
    var items = ["大三上学期", "大三下学期", "大四上学期", "大四下学期"];
    var subtitle = "2019-2020秋季学期";
    String selectedItem = "大三上学期";
    return Row(
      children: <Widget>[
        SizedBox(
          width: 8,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            elevation: 4,
            value: selectedItem,
            onChanged: (String? string) =>
                setState(() => selectedItem = string!),
            selectedItemBuilder: (context) {
              return items.map((String item) {
                return Center(
                    child: Text(
                  item,
                  style: textTheme.headline6,
                ));
              }).toList();
            },
            items: items.map((String item) {
              return DropdownMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item,
                      style: textTheme.normalBig,
                    ),
                    Text(
                      subtitle,
                      style: textTheme.normalSmall,
                    ),
                  ],
                ),
                value: item,
              );
            }).toList(),
          ),
        ),
      ],
    );
    // child: Row(
    //   children: [
    //     Text('大三上学期', textAlign: TextAlign.left),
    //     SizedBox(width: 10),
    //     Image.asset(
    //       Res.arrow_drop_down,
    //       color: ItimeColors.black,
    //     ),
    //   ],
    // ),
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
                    style:
                        textTheme.normal!.copyWith(color: ItimeColors.white))),
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

  Widget _buildSearch() {
    return OverlayMenuButton(
      child: Image.asset(Res.search, width: 48),
      itemBuilder: (BuildContext context) => [
        OverlayMenuItem(
          child: Text("DOTA"),
          value: "dota",
        ),
        OverlayMenuItem(
          child: Text("英雄联盟"),
          value: ["盖伦", "皇子", "提莫"],
        ),
        OverlayMenuItem(
          child: Text("王者荣耀"),
          value: {"name": "王者荣耀"},
        ),
      ],
    );
  }

  Widget _buildScan() {
    return Builder(
      builder: (context) {
        GlobalKey key = GlobalKey();
        return GestureDetector(
          child: Image.asset(
            Res.scan,
            width: 48,
            key: key,
          ),
          onTap: () => PopupMenu(context: context, items: [
            MenuItem(title: "课表"),
            MenuItem(title: "人类"),
            MenuItem(title: "一锅端"),
          ]).show(widgetKey: key),
        );
      },
    );
  }

  Widget _buildCalendar() {
    return GestureDetector(
      child: Image.asset(Res.calendar, width: 48),
      onTap: () {
        _showManageTimetableModal();
      },
    );
  }

  Widget _buildCreate() {
    return ImageButton(
      size: 48,
      image: Image.asset(Res.plus),
      onTap: () {
        _showCreateTimetableModal();
      },
    );
  }

  void _showManageTimetableModal() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(24)),
      //加圆角
      context: context,
      builder: _buildManageTimetableModal,
    );
  }

  void _showCreateTimetableModal() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(24)), //加圆角
      context: context,
      builder: _buildCreateTimetableModal,
    );
  }

  void _showShareTimetableModal({required TimetableModel timetable}) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(24)), //加圆角
      context: context,
      builder: (_) => _buildShareTimetableModal(timetable: timetable),
    );
  }
}
