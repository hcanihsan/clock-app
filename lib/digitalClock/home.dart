import 'package:clock_app/analogClock/analogClock.dart';
import 'package:clock_app/settingsTime/time.dart';
import 'package:circular_clip_route/circular_clip_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(21.0),
                            bottomRight: const Radius.circular(21.0),
                          ),
                        ),
                        margin: EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: Column(children: <Widget>[
                          Container(
                            child: Text('Indonesia',
                                style: TextStyle(
                                    fontFamily: 'KalamRegular',
                                    fontSize: 45,
                                    color: Colors.white)),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              DateFormat("d MMM yyyy").format(DateTime.now()),
                              style: TextStyle(
                                  fontFamily: 'KalamRegular',
                                  fontSize: 23,
                                  color: Colors.white),
                            ),
                          )
                        ])),
                  ],
                ),
                Wrap(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.only(
                            topRight: const Radius.circular(21.0),
                            bottomLeft: const Radius.circular(21.0),
                          ),
                        ),
                        margin: EdgeInsets.only(top: 30, left: 15, right: 15),
                        child: Column(children: <Widget>[
                          Container(
                            child: Text('Jam Digital',
                                style: TextStyle(
                                    fontFamily: 'KalamBold',
                                    fontSize: 45,
                                    color: Colors.black)),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 5, left: 20, right: 20),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(48, 48, 48, 1.0),
                                borderRadius: BorderRadius.only(
                                  topRight: const Radius.circular(21.0),
                                  bottomLeft: const Radius.circular(21.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(48, 48, 48, 1.0)
                                        .withOpacity(0.5),
                                    spreadRadius: 7,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ]),
                            child: Time(),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 30, left: 20, right: 20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(206, 251, 155, 1.0),
                                  Color.fromRGBO(118, 216, 93, 1.0)
                                ],
                              ),
                              borderRadius: BorderRadius.only(
                                topRight: const Radius.circular(10.0),
                                bottomLeft: const Radius.circular(10.0),
                                bottomRight: const Radius.circular(10.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(48, 48, 48, 1.0)
                                      .withOpacity(0.5),
                                  spreadRadius: 7,
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  ' Catatan Kecil ',
                                  style: TextStyle(
                                      fontFamily: 'KalamBold',
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                SaveText(),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30.0),
                          ),
                        ])),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 30.0, right: 90.0, left: 90.0, bottom: 5.0),
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      CircularClipRoute(
                          builder: (context) => analogClock(),
                          expandFrom: context),
                      (Route<dynamic> route) => false);
                },
                padding: EdgeInsets.all(0.0),
                child: Image.asset('assets/images/button_analog_clock.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Code Section Note
class SaveText extends StatefulWidget {
  SaveText({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SaveTextState createState() => _SaveTextState();
}

class _SaveTextState extends State<SaveText> {
  final controllerText = TextEditingController();
  String _data = "";

  @override
  void dispose() {
    controllerText.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _setData();
  }

  _setData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    setState(() {
      _data = (sharedPref.getString('saveNote') ?? 'Tidak Ada Catatan');
    });
  }

  _saveData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.setString('saveNote', controllerText.text);
  }

  @override
  Widget build(BuildContext context) {
    var showText = controllerText;
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: TextField(
            controller: showText,
            textInputAction: TextInputAction.done,
            maxLength: 35,
            maxLines: 1,
            maxLengthEnforced: true,
            style: TextStyle(
                fontFamily: 'KalamRegular', fontSize: 16, color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Tulis catatan disini'),
            textAlign: TextAlign.center,
          ),
        ),
        Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 23.0),
                child: FlatButton(
                  onPressed: () {
                    controllerText.text = "$_data";
                  },
                  padding: EdgeInsets.all(0.0),
                  child: Text(
                    'Lihat Catatan Terakhir',
                    style: TextStyle(fontFamily: 'KalamRegular'),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(left: 21),
                child: FlatButton(
                  onPressed: () {
                    _saveData();
                    _setData();
                  },
                  padding: EdgeInsets.all(0.0),
                  child: Text(
                    'Simpan',
                    style: TextStyle(fontFamily: 'KalamRegular'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
// Code Section Note
