

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/models/timer_model.dart';
import 'package:pomodoro_app/models/timer_status.dart';
import 'package:pomodoro_app/widgets/timer_controller_widget.dart';
import 'package:pomodoro_app/widgets/timer_widget.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  static const WORK_MINUTE = 25;
  static const REST_MINUTES = 5;
  static const int pomodoroCount = 0;
  final TimerModel timerModel = TimerModel(time: WORK_MINUTE, timerStatus: TimerStatus.stop, pomodoroCount: pomodoroCount);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TimerWidget(timerModel: timerModel),
          TimerControllerWidget(timerModel: timerModel, REST_MINUTES: REST_MINUTES, WORK_MINUTE: WORK_MINUTE)
        ],
      ),
    );
  }
}