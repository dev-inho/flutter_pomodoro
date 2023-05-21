import 'package:pomodoro_app/models/timer_status.dart';

class TimerModel {
  int time;
  TimerStatus timerStatus;
  int pomodoroCount;

  TimerModel({
    required this.time,
    required this.timerStatus,
    required this.pomodoroCount
  });
}