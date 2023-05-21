import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/models/timer_model.dart';
import 'package:pomodoro_app/models/timer_status.dart';
import 'package:sprintf/sprintf.dart';

/**
 * TIMER WIDGET
 */
class TimerWidget extends StatefulWidget {
  TimerModel timerModel;

  @override
  _TimerWidgetState createState() => _TimerWidgetState(timerModel: timerModel);

  TimerWidget({super.key, required this.timerModel});
}

class _TimerWidgetState extends State<TimerWidget> {
  TimerModel timerModel;
  var parent;

  _TimerWidgetState({required this.timerModel});

  String secondsToString(int seconds) {
    return sprintf("%02d:%02d", [seconds ~/ 60, seconds % 60]);
  }

  Color setColorOfTimer() {
    Color color = Colors.blue;

    if(timerModel.timerStatus == TimerStatus.play) {
      color = Colors.green;
    } else if(timerModel.timerStatus == TimerStatus.stop) {
      color = Colors.blue;
    } else if(timerModel.timerStatus == TimerStatus.pause) {
      color = Colors.black;
    } else if(timerModel.timerStatus == TimerStatus.rest) {
      color = Colors.purple;
    }

    return color;
  }

  @override
  Widget build(BuildContext context) { /* 위젯 빌드 */
    parent = context.findAncestorStateOfType();

    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: setColorOfTimer(),
      ),
      child: Center(
        child: Text(
          secondsToString(timerModel.time),
          style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}