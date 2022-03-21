import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_mode_project/app_theme/app_theme.dart';
import 'package:theme_mode_project/bloc/app_theme_bloc.dart';

class ThemeHomePage extends StatefulWidget {
  const ThemeHomePage({Key? key}) : super(key: key);

  @override
  _ThemeHomePageState createState() => _ThemeHomePageState();
}

class _ThemeHomePageState extends State<ThemeHomePage> {
  bool _isThemeSwitch = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme homepage'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Switch Theme',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Switch(
                value: _isThemeSwitch,
                onChanged: (val) {
                  if (_isThemeSwitch) {
                    BlocProvider.of<AppThemeBloc>(context)
                        .add(AppThemeEvent(theme: AppTheme.darkTheme));
                  } else {
                    BlocProvider.of<AppThemeBloc>(context)
                        .add(AppThemeEvent(theme: AppTheme.lightTheme));
                  }

                  setState(() {
                    _isThemeSwitch = val;
                  });
                  print(_isThemeSwitch);
                }),
          ],
        ),
      ),
    );
  }
}
