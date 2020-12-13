import 'dart:async';

import 'package:flutter/material.dart';

class Time extends StatefulWidget {
  @override
  _TimeState createState() => _TimeState();
}

class _TimeState extends State<Time> {
  TimeOfDay _timeDay = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeDay.minute != TimeOfDay.now().minute) {
        setState(() {
          _timeDay = TimeOfDay.now();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _periode = _timeDay.period == DayPeriod.am ? "AM" : "PM";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${_timeDay.hour}:${_timeDay.minute}",
            style: TextStyle(
                color: Colors.white, fontSize: 60, fontFamily: 'KalamRegular')),
        SizedBox(width: 3),
        Text(_periode,
            style: TextStyle(
                fontFamily: 'KalamRegular', fontSize: 30, color: Colors.white)),
      ],
    );
  }
}
