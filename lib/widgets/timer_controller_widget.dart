import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pomodoro_app/models/timer_model.dart';
import 'package:pomodoro_app/models/timer_status.dart';
import 'package:pomodoro_app/screens/timer_screen.dart';

/**
 * 타이머 컨트롤러
 */
class TimerControllerWidget extends StatefulWidget {
  TimerModel timerModel;
  int REST_MINUTES;
  int WORK_MINUTE;

  @override
  _TimerControllerWidget createState() => _TimerControllerWidget(timerModel: timerModel, REST_MINUTES: REST_MINUTES, WORK_MINUTE: WORK_MINUTE);

  TimerControllerWidget({
    super.key,
    required this.timerModel,
    required this.REST_MINUTES,
    required this.WORK_MINUTE
  });
}

class _TimerControllerWidget extends State<TimerControllerWidget> {
  TimerModel timerModel;
  int REST_MINUTES;
  int WORK_MINUTE;
  var parent;

  _TimerControllerWidget({
    required this.timerModel,
    required this.REST_MINUTES,
    required this.WORK_MINUTE
  });

  void run() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      // print("타이머 동작중 : ${timerModel.time} / ${timerModel.timerStatus}");

      switch(timerModel.timerStatus) {
        case TimerStatus.play:
          if(timerModel.time <= 0) {
            showToast("작업 완료");
            parent.setState(() {
              timerModel.timerStatus = TimerStatus.rest;
              timerModel.time = REST_MINUTES;
            });
            rest();
          } else {
            parent.setState(() {
              timerModel.time -= 1;
            });
          }

          print("남은시간 : ${timerModel.time} / ${timerModel.timerStatus}");
          break;
        case  TimerStatus.stop:
          if(timerModel.timerStatus == TimerStatus.rest) {
            parent.setState(() {
              timerModel.time = 25;
            });
          } else {
            parent.setState(() {
              timerModel.time = 5;
            });
          }

          timer.cancel();
          break;
        case TimerStatus.pause:
          timer.cancel();
          break;
        case TimerStatus.rest:
          if(timerModel.time <= 0) {
            parent.setState(() {
              timerModel.pomodoroCount += 1;
              timerModel.time = WORK_MINUTE;
              stop();
            });
            showToast("오늘 ${timerModel.pomodoroCount}개의 뽀모도로를 달성했습니다.");
            timer.cancel();
          } else {
            parent.setState(() {
              timerModel.time -= 1;
            });
          }

          print("남은시간 : ${timerModel.time} / ${timerModel.timerStatus}");
          break;
      }
    });
  }

  void play() {
    parent.setState(() {
      timerModel.timerStatus = TimerStatus.play;
    });

    run();
  }

  void stop() {
    parent.setState(() {
      timerModel.timerStatus = TimerStatus.stop;
    });
  }

  void pause() {
    parent.setState(() {
      timerModel.timerStatus = TimerStatus.pause;
    });
  }

  void rest() {
    parent.setState(() {
      timerModel.timerStatus = TimerStatus.rest;
    });
  }
  /**
   * 일시정지 Button
   */
  IconButton pauseButton() {
    return IconButton(
      icon: const Icon(
        Icons.pause_circle,
        color: Colors.blue,
        size: 50,
      ),
      onPressed: () {
        pause();
      },
    );
  }

  /**
   * 멈춤 Button
   */
  IconButton stopButton() {
    return IconButton(
      icon: const Icon(
        Icons.stop_circle,
        color: Colors.redAccent,
        size: 50,
      ),
      onPressed: () {
        stop();
      },
    );
  }

  /**
   * 시작 Button
   */
  IconButton playButton() {
    return IconButton(
      icon: const Icon(
        Icons.play_circle,
        color: Colors.green,
        size: 50,
      ),
      onPressed: () {
        play();
      },
    );
  }

  /**
   * TimerStatus별 버튼 목록
   */
  List<IconButton> getButtons() {
    List<IconButton> buttonList = [];

    if(timerModel.timerStatus == TimerStatus.play) {
      buttonList.add(pauseButton());
      buttonList.add(stopButton());
    } else if(timerModel.timerStatus == TimerStatus.pause) {
      buttonList.add(playButton());
      buttonList.add(stopButton());
    } else if(timerModel.timerStatus == TimerStatus.stop) {
      buttonList.add(playButton());
    } else if(timerModel.timerStatus == TimerStatus.rest) {
      buttonList.add(playButton());
      buttonList.add(stopButton());
    }

    return buttonList;
  }

  @override
  Widget build(BuildContext context) {
    parent = context.findAncestorStateOfType();

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: getButtons()
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}