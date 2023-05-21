
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/screens/timer_screen.dart';

void main() => runApp(PomodoroApp());


class PomodoroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "뽀모도로 앱",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("뽀모도로 타이머"),
        ),
        body: TimerScreen(),
      ),
    );
  }
}