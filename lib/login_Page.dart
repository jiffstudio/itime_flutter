import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itime_frontend/data/user_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itime_frontend/views/timetable_page.dart';

import 'models/loginResultResponse.dart';

TextEditingController userContaller = new TextEditingController();
TextEditingController passwordContaller = new TextEditingController();

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromARGB(255, 179, 163, 224),
          child: Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    width: double.infinity,
                    height: 418,
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        Text("教务系统认证",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Color.fromARGB(255, 104, 104, 104),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center),
                        SizedBox(height: 30),
                        LoginText(),
                        SizedBox(height: 24),
                        PassWordText(),
                        SizedBox(height: 30),
                        LoginButon(),
                        SizedBox(height: 10),
                        Text('用密码登录',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[400]))
                      ],
                    ),
                  )),
              //图片
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18, 44, 18, 0),
                  child: Container(
                    width: double.infinity,
                    height: 354,
                    child: Image.asset('images/cover.png', fit: BoxFit.fill),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}

//登录账号框
class LoginText extends StatefulWidget {
  LoginText({Key? key}) : super(key: key);

  @override
  _LoginTextState createState() => _LoginTextState();
}

class _LoginTextState extends State<LoginText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(43.5, 0, 43.5, 0),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: TextField(
          controller: userContaller,
          decoration:
              InputDecoration(border: OutlineInputBorder(), labelText: "学号"),
        ),
      ),
    );
  }
}

//用户密码框
class PassWordText extends StatefulWidget {
  PassWordText({Key? key}) : super(key: key);

  @override
  _PassWordTextState createState() => _PassWordTextState();
}

class _PassWordTextState extends State<PassWordText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(43.5, 0, 43.5, 0),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: TextField(
          obscureText: true,
          controller: passwordContaller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "密码",
          ),
        ),
      ),
    );
  }
}

//登录按钮
class LoginButon extends StatefulWidget {
  LoginButon({Key? key}) : super(key: key);

  @override
  _LoginButonState createState() => _LoginButonState();
}

class _LoginButonState extends State<LoginButon> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 94, 90, 188),
            borderRadius: BorderRadius.all(Radius.circular(150.0))),
        child: IconButton(
            icon: Icon(Icons.arrow_forward,
                color: Color.fromARGB(255, 222, 222, 248)),
            onPressed: () async {
              print(userContaller.text);
              print(passwordContaller.text);
              LoginResultResponse? response = await UserApi().login(
                  studentId: userContaller.text, pwd: passwordContaller.text);
              Navigator.of(context)
                  .pushReplacement(new MaterialPageRoute(builder: (context) {
                return TimetablePage(response!.data);
              }));
              try {} catch (e) {
                print('有错误');
                Fluttertoast.showToast(
                    msg: "账号或密码错误",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                );
              }
            }));
  }
}
