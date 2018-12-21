import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter1/calc/CalculatorPage.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter1/anim/Anim.dart';
import 'package:flutter1/drawer/drawer.dart';
import 'package:flutter1/form/formPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final main_key = GlobalKey<ScaffoldState>();

    return CupertinoApp(
      title: 'Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: main_key,
        body: MainPage(),
        appBar: AppBar(
          title: Text('Demos'),
          actions: <Widget>[
          IconButton(
            icon: Icon(Icons.smoking_rooms),
            onPressed: () {
              final snack = SnackBar(
                content: Text('Yay! A SnackBar'),
                action: SnackBarAction(label: 'Bye', onPressed: () {}),
              );
              main_key.currentState.showSnackBar(snack);
            },
         ),
          ],
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('zh', 'CN'),
        const Locale('ja', 'JP'),
      ],
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Calculator'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CalculatorPage()));
          },
        ),
        ListTile(
          title: Text('Animation'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => AnimPage()));
          },
        ),
        ListTile(
          title: Text('Drawer'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => DrawerPage()));
          },
        ),
        ListTile(
          title: Text('Form'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => FormPage()));
          },
        )
      ],
    );
  }

}
