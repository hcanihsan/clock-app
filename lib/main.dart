import 'package:clock_app/digitalClock/home.dart';
import 'package:clock_app/intro_app/intro_app.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new IntroApp(),
    );
  }
}

class IntroApp extends StatefulWidget {
  @override
  _IntroAppState createState() => new _IntroAppState();
}

class _IntroAppState extends State<IntroApp> with AfterLayoutMixin<IntroApp> {
  Future cekScreenPertama() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool _terlihat = (pref.getBool('terlihat') ?? false);

    if (_terlihat) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Home()));
    } else {
      await pref.setBool('terlihat', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new intro_app()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets\images\splash_screen.png"),
        fit: BoxFit.cover,
      )),
    ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    cekScreenPertama();
  }
}
