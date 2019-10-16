import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './bmi.dart';
import './settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: const<LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
      ],
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), title: Text('BMI')),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings_solid),
              title: Text('Settings'))
        ],
      ),
      tabBuilder: (BuildContext context, int i) {
        if (i == 0) {
          return Bmi();
        } else {
          return Settings();
        }
      },
    );
  }
}
