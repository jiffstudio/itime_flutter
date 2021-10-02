import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itime_frontend/blocs/timetable/timetable_bloc.dart';
import 'package:itime_frontend/blocs/user/user_bloc.dart';
import 'package:itime_frontend/pages/timetable_page.dart';
import 'package:itime_frontend/styles/itime_colors.dart';
import 'package:itime_frontend/theme.dart';

TextEditingController userContaller = new TextEditingController();
TextEditingController passwordContaller = new TextEditingController();

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => LoginPage());
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    color: ItimeColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                width: double.infinity,
                height: 418,
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    Text("教务系统认证",
                        style: textTheme.headline5,
                        textAlign: TextAlign.center),
                    SizedBox(height: 30),
                    LoginText(),
                    SizedBox(height: 24),
                    PassWordText(),
                    SizedBox(height: 30),
                    LoginButton(),
                    SizedBox(height: 10),
                    Text('用密码登录',
                        style: TextStyle(fontSize: 12, color: Colors.grey[400]))
                  ],
                ),
              )),
          //图片
          if (MediaQuery.of(context).viewInsets == EdgeInsets.zero)
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
    ));
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
class LoginButton extends StatefulWidget {
  LoginButton({Key? key}) : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 94, 90, 188),
            borderRadius: BorderRadius.all(Radius.circular(150.0))),
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLogged) {
              context
                  .read<TimetableBloc>()
                  .add(SetTimetable(timetables: state.data.arr));
              context.read<UserBloc>().add(Unauthorize());
              //TODO: remove false
              Navigator.of(context)
                  .pushAndRemoveUntil(TimetablePage.route(), (route) => false);
            }
          },
          child: IconButton(icon: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLogging)
                return CircularProgressIndicator(color: ItimeColors.white);
              else
                return Icon(Icons.arrow_forward,
                    color: Color.fromARGB(255, 222, 222, 248));
            },
          ), onPressed: () {
            context
                .read<UserBloc>()
                .add(Login(userContaller.text, passwordContaller.text));
          }),
        ));
  }
}
