// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static AppLocalizationDelegate getLocaleDelegate(Locale locale){
    return AppLocalizationDelegate(locale: locale);
  }

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Timetable`
  String get timetable {
    return Intl.message(
      'Timetable',
      name: 'timetable',
      desc: '',
      args: [],
    );
  }

  /// `Canteen`
  String get canteen {
    return Intl.message(
      'Canteen',
      name: 'canteen',
      desc: '',
      args: [],
    );
  }

  /// `Select all`
  String get select_all {
    return Intl.message(
      'Select all',
      name: 'select_all',
      desc: '',
      args: [],
    );
  }

  /// `Deselect all`
  String get deselect_all {
    return Intl.message(
      'Deselect all',
      name: 'deselect_all',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get canteen_no_data {
    return Intl.message(
      'No data available',
      name: 'canteen_no_data',
      desc: '',
      args: [],
    );
  }

  /// `Chicken egg`
  String additive(String key) {
    return Intl.message(
      'Chicken egg',
      name: 'canteen_additive_$key',
      desc: '',
      args: [],
    );
  }

  /// `Allergenes`
  String get canteen_allergenes {
    return Intl.message(
      'Allergenes',
      name: 'canteen_allergenes',
      desc: '',
      args: [],
    );
  }

  /// `Timetable not configured.`
  String get settings_timetable_not_configured {
    return Intl.message(
      'Timetable not configured.',
      name: 'settings_timetable_not_configured',
      desc: '',
      args: [],
    );
  }

  /// `You first have to choose your semester in the settings.`
  String get settings_semester_not_configured {
    return Intl.message(
      'You first have to choose your semester in the settings.',
      name: 'settings_semester_not_configured',
      desc: '',
      args: [],
    );
  }

  /// `Go to semester settings`
  String get settings_semester_not_configured_button {
    return Intl.message(
      'Go to semester settings',
      name: 'settings_semester_not_configured_button',
      desc: '',
      args: [],
    );
  }

  /// `You first have to choose your course of studies in the settings.`
  String get settings_course_not_configured {
    return Intl.message(
      'You first have to choose your course of studies in the settings.',
      name: 'settings_course_not_configured',
      desc: '',
      args: [],
    );
  }

  /// `Go to course of studies settings`
  String get settings_course_not_configured_button {
    return Intl.message(
      'Go to course of studies settings',
      name: 'settings_course_not_configured_button',
      desc: '',
      args: [],
    );
  }

  /// `You first have to choose your lectures in the settings.`
  String get settings_lectures_not_configured {
    return Intl.message(
      'You first have to choose your lectures in the settings.',
      name: 'settings_lectures_not_configured',
      desc: '',
      args: [],
    );
  }

  /// `Go to lecture settings`
  String get settings_lectures_not_configured_button {
    return Intl.message(
      'Go to lecture settings',
      name: 'settings_lectures_not_configured_button',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get settings_category_general {
    return Intl.message(
      'General',
      name: 'settings_category_general',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get settings_dark_theme_title {
    return Intl.message(
      'Dark theme',
      name: 'settings_dark_theme_title',
      desc: '',
      args: [],
    );
  }

  /// `Switch on to join the dark side`
  String get settings_dark_theme_description {
    return Intl.message(
      'Switch on to join the dark side',
      name: 'settings_dark_theme_description',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settings_language_title {
    return Intl.message(
      'Language',
      name: 'settings_language_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose the app language`
  String get settings_language_description {
    return Intl.message(
      'Choose the app language',
      name: 'settings_language_description',
      desc: '',
      args: [],
    );
  }

  /// `Timetable`
  String get settings_category_timetable {
    return Intl.message(
      'Timetable',
      name: 'settings_category_timetable',
      desc: '',
      args: [],
    );
  }

  /// `Semester`
  String get settings_semester_title {
    return Intl.message(
      'Semester',
      name: 'settings_semester_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose your Semester`
  String get settings_semester_description {
    return Intl.message(
      'Choose your Semester',
      name: 'settings_semester_description',
      desc: '',
      args: [],
    );
  }

  /// `Course of studies`
  String get settings_course_title {
    return Intl.message(
      'Course of studies',
      name: 'settings_course_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose your course of studies`
  String get settings_course_description {
    return Intl.message(
      'Choose your course of studies',
      name: 'settings_course_description',
      desc: '',
      args: [],
    );
  }

  /// `Lectures`
  String get settings_lectures_title {
    return Intl.message(
      'Lectures',
      name: 'settings_lectures_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose your lectures`
  String get settings_lectures_description {
    return Intl.message(
      'Choose your lectures',
      name: 'settings_lectures_description',
      desc: '',
      args: [],
    );
  }

  /// `You cannot add more than 35 lectures.`
  String get settings_lectures_max {
    return Intl.message(
      'You cannot add more than 35 lectures.',
      name: 'settings_lectures_max',
      desc: '',
      args: [],
    );
  }

  /// `Select all`
  String get settings_lectures_select_all {
    return Intl.message(
      'Select all',
      name: 'settings_lectures_select_all',
      desc: '',
      args: [],
    );
  }

  /// `Deselect all`
  String get settings_lectures_deselect_all {
    return Intl.message(
      'Deselect all',
      name: 'settings_lectures_deselect_all',
      desc: '',
      args: [],
    );
  }

  /// `License`
  String get settings_license_title {
    return Intl.message(
      'License',
      name: 'settings_license_title',
      desc: '',
      args: [],
    );
  }

  /// `Show licenses of used third party packages`
  String get settings_license_description {
    return Intl.message(
      'Show licenses of used third party packages',
      name: 'settings_license_description',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  final Locale? locale;
  const AppLocalizationDelegate({this.locale});

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(this.locale ?? locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => true;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
