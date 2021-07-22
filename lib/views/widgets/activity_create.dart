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
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          OneLineText(),
          SizedBox(height: 15,),
          SecondLineText(),
        ],
      ),
    );
  }
}

class OneLineText extends StatefulWidget {
  OneLineText({Key? key}) : super(key: key);

  @override
  _OneLineTextState createState() => _OneLineTextState();
}

class _OneLineTextState extends State<OneLineText> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              prefix: Text('名称',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 0, 0, 0),
                  )),
              suffix: Text(
                '必填',
                style: TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 252, 92, 123)),
              )),
        ));
  }
}

class SecondLineText extends StatefulWidget {
  SecondLineText({Key? key}) : super(key: key);

  @override
  _SecondLineTextState createState() => _SecondLineTextState();
}

// ignore: unused_element
class _SecondLineTextState extends State<SecondLineText> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              prefix: Text('地点',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 0, 0, 0),
                  )),
              suffix: Text(
                '非必填',
                style: TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 172, 173, 175)),
              )),
        ));
  }
}


