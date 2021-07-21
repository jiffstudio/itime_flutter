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
  String get canteen_additive_ei {
    return Intl.message(
      'Chicken egg',
      name: 'canteen_additive_ei',
      desc: '',
      args: [],
    );
  }

  /// `Peanut`
  String get canteen_additive_en {
    return Intl.message(
      'Peanut',
      name: 'canteen_additive_en',
      desc: '',
      args: [],
    );
  }

  /// `Fish`
  String get canteen_additive_fi {
    return Intl.message(
      'Fish',
      name: 'canteen_additive_fi',
      desc: '',
      args: [],
    );
  }

  /// `Wheat containing gluten`
  String get canteen_additive_gl {
    return Intl.message(
      'Wheat containing gluten',
      name: 'canteen_additive_gl',
      desc: '',
      args: [],
    );
  }

  /// `Wheat`
  String get canteen_additive_glw {
    return Intl.message(
      'Wheat',
      name: 'canteen_additive_glw',
      desc: '',
      args: [],
    );
  }

  /// `Rye`
  String get canteen_additive_glr {
    return Intl.message(
      'Rye',
      name: 'canteen_additive_glr',
      desc: '',
      args: [],
    );
  }

  /// `Barley`
  String get canteen_additive_glg {
    return Intl.message(
      'Barley',
      name: 'canteen_additive_glg',
      desc: '',
      args: [],
    );
  }

  /// `Oats`
  String get canteen_additive_glh {
    return Intl.message(
      'Oats',
      name: 'canteen_additive_glh',
      desc: '',
      args: [],
    );
  }

  /// `Spelt`
  String get canteen_additive_gld {
    return Intl.message(
      'Spelt',
      name: 'canteen_additive_gld',
      desc: '',
      args: [],
    );
  }

  /// `Garlic`
  String get canteen_additive_kn {
    return Intl.message(
      'Garlic',
      name: 'canteen_additive_kn',
      desc: '',
      args: [],
    );
  }

  /// `Crustaceans`
  String get canteen_additive_kr {
    return Intl.message(
      'Crustaceans',
      name: 'canteen_additive_kr',
      desc: '',
      args: [],
    );
  }

  /// `Lupins`
  String get canteen_additive_lu {
    return Intl.message(
      'Lupins',
      name: 'canteen_additive_lu',
      desc: '',
      args: [],
    );
  }

  /// `Milk and lactose`
  String get canteen_additive_mi {
    return Intl.message(
      'Milk and lactose',
      name: 'canteen_additive_mi',
      desc: '',
      args: [],
    );
  }

  /// `Nuts`
  String get canteen_additive_sc {
    return Intl.message(
      'Nuts',
      name: 'canteen_additive_sc',
      desc: '',
      args: [],
    );
  }

  /// `Almonds`
  String get canteen_additive_scm {
    return Intl.message(
      'Almonds',
      name: 'canteen_additive_scm',
      desc: '',
      args: [],
    );
  }

  /// `Hazelnuts`
  String get canteen_additive_sch {
    return Intl.message(
      'Hazelnuts',
      name: 'canteen_additive_sch',
      desc: '',
      args: [],
    );
  }

  /// `Walnuts`
  String get canteen_additive_scw {
    return Intl.message(
      'Walnuts',
      name: 'canteen_additive_scw',
      desc: '',
      args: [],
    );
  }

  /// `Cashews`
  String get canteen_additive_scc {
    return Intl.message(
      'Cashews',
      name: 'canteen_additive_scc',
      desc: '',
      args: [],
    );
  }

  /// `Pistachios`
  String get canteen_additive_scp {
    return Intl.message(
      'Pistachios',
      name: 'canteen_additive_scp',
      desc: '',
      args: [],
    );
  }

  /// `Sesame seeds`
  String get canteen_additive_se {
    return Intl.message(
      'Sesame seeds',
      name: 'canteen_additive_se',
      desc: '',
      args: [],
    );
  }

  /// `Mustard`
  String get canteen_additive_sf {
    return Intl.message(
      'Mustard',
      name: 'canteen_additive_sf',
      desc: '',
      args: [],
    );
  }

  /// `Celery`
  String get canteen_additive_sl {
    return Intl.message(
      'Celery',
      name: 'canteen_additive_sl',
      desc: '',
      args: [],
    );
  }

  /// `Soy`
  String get canteen_additive_so {
    return Intl.message(
      'Soy',
      name: 'canteen_additive_so',
      desc: '',
      args: [],
    );
  }

  /// `Sulfur dioxide and Sulfites`
  String get canteen_additive_sw {
    return Intl.message(
      'Sulfur dioxide and Sulfites',
      name: 'canteen_additive_sw',
      desc: '',
      args: [],
    );
  }

  /// `Molluscs`
  String get canteen_additive_wt {
    return Intl.message(
      'Molluscs',
      name: 'canteen_additive_wt',
      desc: '',
      args: [],
    );
  }

  /// `with food coloring`
  String get canteen_additive_1 {
    return Intl.message(
      'with food coloring',
      name: 'canteen_additive_1',
      desc: '',
      args: [],
    );
  }

  /// `with preservatives`
  String get canteen_additive_2 {
    return Intl.message(
      'with preservatives',
      name: 'canteen_additive_2',
      desc: '',
      args: [],
    );
  }

  /// `with antioxidants`
  String get canteen_additive_3 {
    return Intl.message(
      'with antioxidants',
      name: 'canteen_additive_3',
      desc: '',
      args: [],
    );
  }

  /// `with flavor enhancers`
  String get canteen_additive_4 {
    return Intl.message(
      'with flavor enhancers',
      name: 'canteen_additive_4',
      desc: '',
      args: [],
    );
  }

  /// `sulphured`
  String get canteen_additive_5 {
    return Intl.message(
      'sulphured',
      name: 'canteen_additive_5',
      desc: '',
      args: [],
    );
  }

  /// `blackened`
  String get canteen_additive_6 {
    return Intl.message(
      'blackened',
      name: 'canteen_additive_6',
      desc: '',
      args: [],
    );
  }

  /// `waxed`
  String get canteen_additive_7 {
    return Intl.message(
      'waxed',
      name: 'canteen_additive_7',
      desc: '',
      args: [],
    );
  }

  /// `with phosphates`
  String get canteen_additive_8 {
    return Intl.message(
      'with phosphates',
      name: 'canteen_additive_8',
      desc: '',
      args: [],
    );
  }

  /// `with sweeteners`
  String get canteen_additive_9 {
    return Intl.message(
      'with sweeteners',
      name: 'canteen_additive_9',
      desc: '',
      args: [],
    );
  }

  /// `contains a phenylalanine source`
  String get canteen_additive_10 {
    return Intl.message(
      'contains a phenylalanine source',
      name: 'canteen_additive_10',
      desc: '',
      args: [],
    );
  }

  /// `with a type of sugar and/or sweetener`
  String get canteen_additive_11 {
    return Intl.message(
      'with a type of sugar and/or sweetener',
      name: 'canteen_additive_11',
      desc: '',
      args: [],
    );
  }

  /// `cocoa-based icing`
  String get canteen_additive_13 {
    return Intl.message(
      'cocoa-based icing',
      name: 'canteen_additive_13',
      desc: '',
      args: [],
    );
  }

  /// `Gelatin`
  String get canteen_additive_14 {
    return Intl.message(
      'Gelatin',
      name: 'canteen_additive_14',
      desc: '',
      args: [],
    );
  }

  /// `Alcohol`
  String get canteen_additive_99 {
    return Intl.message(
      'Alcohol',
      name: 'canteen_additive_99',
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
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
