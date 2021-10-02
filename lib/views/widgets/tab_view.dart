import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:itime_frontend/styles/itime_colors.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class TabView extends StatefulWidget {
  final TabViewController? controller;
  final int itemCount;
  final IndexedWidgetBuilder tabBuilder;
  final IndexedWidgetBuilder? pageBuilder;
  final Widget? stub;
  final ValueChanged<int>? onPositionChange;
  final ValueChanged<double>? onScroll;
  final int? initPosition;
  final int? position;
  final ValueChanged<int>? onTap;

  TabView({
    required this.itemCount,
    required this.tabBuilder,
    this.pageBuilder,
    this.stub,
    this.onPositionChange,
    this.onScroll,
    this.initPosition,
    this.controller,
    this.onTap,
    this.position,
  });

  @override
  _TabViewState createState() => _TabViewState();
}

class TabViewController implements TabController {
  late TabController _controller;

  @override
  int get index => _controller.index;

  @override
  double get offset => _controller.offset;

  @override
  void addListener(VoidCallback listener) {
    _controller.addListener(listener);
  }

  @override
  void animateTo(int value,
      {Duration duration = kTabScrollDuration, Curve curve = Curves.ease}) {
    _controller.animateTo(value, duration: duration, curve: curve);
  }

  @override
  Animation<double>? get animation => _controller.animation;

  @override
  void dispose() {
    _controller.dispose();
  }

  @override
  bool get hasListeners => _controller.hasListeners;

  @override
  bool get indexIsChanging => _controller.indexIsChanging;

  @override
  int get length => _controller.length;

  @override
  void notifyListeners() {
    _controller.notifyListeners();
  }

  @override
  // TODO: implement previousIndex
  int get previousIndex => _controller.previousIndex;

  @override
  void removeListener(VoidCallback listener) {
    _controller.removeListener(listener);
  }

  void apply(TabController controller) {
    _controller = controller;
  }

  @override
  set index(int value) {
    _controller.index = value;
  }

  @override
  set offset(double value) {
    _controller.offset = value;
  }
}

class _TabViewState extends State<TabView> with TickerProviderStateMixin {
  late TabViewController _controller;
  late int _currentCount;
  int _currentPosition = 0;

  @override
  void initState() {
    _currentPosition = widget.initPosition ?? _currentPosition;
    _controller = widget.controller ?? TabViewController();
    _controller.apply(TabController(
      length: widget.itemCount,
      vsync: this,
      initialIndex: _currentPosition,
    ));
    _controller.addListener(onPositionChange);
    _controller.animation!.addListener(onScroll);
    _currentCount = widget.itemCount;
    if (widget.initPosition != null) {
      _controller.animateTo(widget.initPosition!);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(TabView oldWidget) {
    if (_currentCount != widget.itemCount) {
      _controller.animation!.removeListener(onScroll);
      _controller.removeListener(onPositionChange);
      _controller.dispose();

      _currentPosition = widget.initPosition ?? _currentPosition;

      if (_currentPosition > widget.itemCount - 1) {
        _currentPosition = widget.itemCount - 1;
        _currentPosition = _currentPosition < 0 ? 0 : _currentPosition;
        if (widget.onPositionChange is ValueChanged<int>) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            if (mounted) {
              widget.onPositionChange!(_currentPosition);
            }
          });
        }
      }

      _currentCount = widget.itemCount;
      setState(() {
        _controller.apply(TabController(
          length: widget.itemCount,
          vsync: this,
          initialIndex: _currentPosition,
        ));
        _controller.addListener(onPositionChange);
        _controller.animation!.addListener(onScroll);
      });
    } else if (widget.position != null) {
      _controller.animateTo(widget.position!);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.animation!.removeListener(onScroll);
    _controller.removeListener(onPositionChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount < 1) return widget.stub ?? Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: TabBar(
            isScrollable: true,
            controller: _controller,
            labelColor: Theme.of(context).primaryColor,
            tabs: List.generate(
              widget.itemCount,
              (index) => widget.tabBuilder(context, index),
            ),
            onTap: widget.onTap,
            physics: const BouncingScrollPhysics(),
            labelPadding: EdgeInsets.all(0),
            unselectedLabelColor: ItimeColors.normal,
            //Theme.of(context).hintColor,
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
          ),
        ),
        if (widget.pageBuilder != null)
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: List.generate(
                widget.itemCount,
                (index) => widget.pageBuilder!(context, index),
              ),
            ),
          ),
      ],
    );
  }

  onPositionChange() {
    if (!_controller.indexIsChanging) {
      _currentPosition = _controller.index;
      if (widget.onPositionChange is ValueChanged<int>) {
        widget.onPositionChange!(_currentPosition);
      }
    }
  }

  onScroll() {
    if (widget.onScroll is ValueChanged<double>) {
      widget.onScroll!(_controller.animation!.value);
    }
  }
}
