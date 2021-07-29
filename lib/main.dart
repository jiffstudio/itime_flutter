import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:itime_frontend/splash.dart';
import 'package:itime_frontend/views/timetable_page.dart';
import 'package:itime_frontend/views/widgets/activity_create.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';

import 'blocs/bloc_observer.dart';
import 'blocs/canteen/canteen_bloc.dart';
import 'blocs/settings/settings_bloc.dart';
import 'blocs/timetable/timetable_bloc.dart';
import 'generated/l10n.dart';
import 'generated/l10n.g.dart';
import 'theme.dart';
import 'views/home.dart';

void main() async {
  // 在runApp()之前执行命令时，应先调用ensureInitialized()，主要进行3个重要绑定：
  // SchedulerBinding（调度绑定），RendererBinding（渲染绑定）和WidgetsBinding，
  // 这些绑定全部完成以后，执行指令才不会报错
  WidgetsFlutterBinding.ensureInitialized();

  // Bloc logging
  Bloc.observer = SimpleBlocObserver();

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
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (context) => SettingsBloc()),
        BlocProvider(lazy: false, create: (context) => TimetableBloc()),
        BlocProvider(lazy: false, create: (context) => CanteenBloc()),
      ],
      child: BlocBuilder<SettingsBloc, Settings>(
        buildWhen: (previous, current) =>
            previous.themeMode != current.themeMode ||
            previous.locale != current.locale,
        builder: (context, settings) {
          if (!settings.initialized) {
            return Container(color: kDark);
          }

          return MaterialApp(
            title: '时刻',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              TimetableLocalizationsDelegate(),
              //Intl生成的本地化代理
              GenerateLocaleDelegate.getLocaleDelegate(Locale(settings.locale ?? 'zh', '')),
              // 指定本地化的字符串和一些其他的值
              GlobalMaterialLocalizations.delegate,
              // 指定默认的文本排列方向, 由左到右或由右到左
              GlobalWidgetsLocalizations.delegate,

            ],
            supportedLocales: ItimeApp.supportedLanguageCodes
                .map((languageCode) => Locale(languageCode, ''))
                .toList(),
            themeMode: settings.themeMode,
            theme: theme,
            darkTheme: darkTheme,
            // home: HomeScreen(),
            home: SplashPage(),
          );
        },
      ),
    );
  }
}
