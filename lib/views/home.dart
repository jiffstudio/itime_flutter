import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:itime_frontend/generated/l10n.dart';

import '../pages/timetable_page.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// SingleTickerProviderStateMixin用于动画控制
class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container();
    // return Scaffold(
    //   body: TimetablePage(),
    // );
  }

}
