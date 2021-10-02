import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:itime_frontend/blocs/token/token_cubit.dart';
import 'package:itime_frontend/pages/login_page.dart';
import 'package:itime_frontend/pages/splash_page.dart';
import 'package:itime_frontend/pages/timetable_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';
import 'package:itime_frontend/views/widgets/term.dart';
import 'blocs/bloc_observer.dart';
import 'blocs/timetable/timetable_bloc.dart';
import 'blocs/user/user_bloc.dart';
import 'data/base_api.dart';
import 'generated/l10n.g.dart';
import 'theme.dart';

void main() async {
  // 在runApp()之前执行命令时，应先调用ensureInitialized()，主要进行3个重要绑定：
  // SchedulerBinding（调度绑定），RendererBinding（渲染绑定）和WidgetsBinding，
  // 这些绑定全部完成以后，执行指令才不会报错
  WidgetsFlutterBinding.ensureInitialized();

  // Bloc日志输出
  Bloc.observer = SimpleBlocObserver();

  // Bloc持久化
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  // 设置支持的屏幕方向：竖屏-正、竖屏-倒
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await TimeMachine.initialize({'rootBundle': rootBundle});
  runApp(ItimeApp());
}

final _supportedLocales = [
  const Locale('de'),
  const Locale('en'),
  const Locale('es'),
  const Locale('ja'),
  const Locale('zh', 'CN'),
  const Locale('zh', 'TW'),
];

class ItimeApp extends StatefulWidget {
  //支持本地化的语言编码列表
  static List<String> supportedLanguageCodes = ['zh', 'en'];

  @override
  _ItimeAppState createState() => _ItimeAppState();
}

class _ItimeAppState extends State<ItimeApp> {
  bool _isAuthorized = false;

  @override
  void initState() {
    super.initState();
    Term.load();
    _initClient();
  }

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = UserBloc();
    TimetableBloc timetableBloc = TimetableBloc(userBloc: userBloc);
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (context) => timetableBloc),
        BlocProvider(lazy: false, create: (context) => userBloc),
        BlocProvider(lazy: false, create: (context) => TokenCubit()),
      ],
      child: MaterialApp(
        title: '时刻',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          TimetableLocalizationsDelegate(),
          //Intl生成的本地化代理
          GenerateLocaleDelegate.getLocaleDelegate(
              Locale('zh', '')),
          // 指定本地化的字符串和一些其他的值
          GlobalMaterialLocalizations.delegate,
          // 指定默认的文本排列方向, 由左到右或由右到左
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: ItimeApp.supportedLanguageCodes
            .map((languageCode) => Locale(languageCode, ''))
            .toList(),
        themeMode: ThemeMode.light,
        theme: theme,
        darkTheme: darkTheme,
        // home: HomeScreen(),
        home: _isAuthorized ? TimetablePage() : LoginPage(),
        navigatorKey: Routes.navigatorKey,
      ),
    );
  }

  Future<void> _initClient() async {
    await BaseApi.init();
    _isAuthorized = await BaseApi.isAuthorized();
    setState(() {});
  }
}

class Routes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}
