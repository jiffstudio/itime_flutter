import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itime_frontend/generated/l10n.dart';

import '../blocs/settings/settings_bloc.dart';
import '../theme.dart';
import 'settings/course_of_studies_settings.dart';
import 'settings/language_settings.dart';
import 'settings/lecture_settings.dart';
import 'settings/semester_settings.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: BlocBuilder<SettingsBloc, Settings>(
        builder: (context, settings) => ListView(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          children: <Widget>[
            _SettingsTitle(
              title: S.of(context).settings_category_general,
            ),
            _SettingsButton(
              title: S.of(context).settings_dark_theme_title,
              subtitle: S.of(context).settings_dark_theme_description,
              value: settings.themeMode == ThemeMode.dark,
              onChanged: (value) => BlocProvider.of<SettingsBloc>(context).add(
                Settings(themeMode: value ? ThemeMode.dark : ThemeMode.light),
              ),
            ),
            _SettingsSpacer(),
            _SettingsLink(
              title: S.of(context).settings_language_title,
              subtitle: S.of(context).settings_language_description,
              builder: (context) => LanguageSettings(),
            ),
            _SettingsSpacer(),
            _SettingsLinkButton(
              title: S.of(context).settings_license_title,
              subtitle: S.of(context).settings_license_description,
              onTap: () async => showLicensePage(
                context: context,
                applicationName: 'TH Rosenheim',
                applicationLegalese:
                    await rootBundle.loadString('assets/license.txt'),
              ),
            ),
            _SettingsSpacer(),
            _SettingsTitle(
              title: S.of(context).settings_category_timetable,
            ),
            _SettingsLink(
              title: S.of(context).settings_semester_title,
              subtitle: S.of(context).settings_semester_description,
              builder: (context) => SemesterSettings(),
            ),
            _SettingsSpacer(),
            _SettingsLink(
              title: S.of(context).settings_category_timetable,
              subtitle: S.of(context).settings_course_description,
              builder: (context) => CourseOfStudiesSettings(),
            ),
            _SettingsSpacer(),
            _SettingsLink(
              title: S.of(context).settings_lectures_title,
              subtitle: S.of(context).settings_lectures_description,
              builder: (context) => LectureSettings(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSpacer extends StatelessWidget {
  const _SettingsSpacer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 8);
  }
}

class _SettingsTitle extends StatelessWidget {
  final String title;

  const _SettingsTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(6, 8, 6, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

class _SettingsLink extends StatelessWidget {
  final String title;
  final String subtitle;
  final WidgetBuilder builder;

  const _SettingsLink({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SettingsLinkButton(
      title: title,
      subtitle: subtitle,
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: builder)),
    );
  }
}

class _SettingsLinkButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsLinkButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
