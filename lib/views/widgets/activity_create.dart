import 'package:flutter/material.dart';
import 'package:itime_frontend/styles/itime_colors.dart';
import 'package:itime_frontend/theme.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Column(

    );
  }
}

//第一个文本框
class SelfLineText extends StatefulWidget {
  SelfLineText({Key? key}) : super(key: key);

  @override
  _SelfLineTextState createState() => _SelfLineTextState();
}

class _SelfLineTextState extends State<SelfLineText> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Padding(
            padding: EdgeInsets.all(7),
            child: Row(
              children: [
                Text('名称',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 252, 92, 123),
                    )),
                Expanded(child: TextField()),
                Text(
                  '必填',
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 172, 173, 175)),
                )
              ],
            )));
  }
}

//第二个文本框
class TwoLineText extends StatefulWidget {
  TwoLineText({Key? key}) : super(key: key);

  @override
  _SelfLineTextState createState() => _SelfLineTextState();
}

// ignore: unused_element
class _TwoLineTextState extends State<SelfLineText> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Padding(
            padding: EdgeInsets.all(7),
            child: Row(
              children: [
                Text('地点',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )),
                Expanded(child: TextField()),
                Text(
                  '非必填',
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 172, 173, 175)),
                )
              ],
            )));
  }
}
