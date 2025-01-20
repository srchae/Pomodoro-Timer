import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes; // 25분으로 설정
  // late는 이 속성을 당장 초기화 하지 않아도 된다는 의미
  late Timer timer;
  bool isRunning = false;
  int totalPomodoros = 0;

  // onTick : 타이머를 실행하는 함수
  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        totalSeconds = twentyFiveMinutes;
        isRunning = false;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  // onStartPressed : 타이머 초기화를 시작하는 함수 (1초마다 onTick을 실행)
  void onStartPressed() {
    timer = Timer.periodic(Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String formatSeconds(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  void onRestartPressed() {
    setState(() {
      totalSeconds = twentyFiveMinutes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Flexible : 내부 요소의 크기를 지정하지 않고 유연하게 할당될 수 있도록 한다.
          SizedBox(
            height: 20,
          ),
          Flexible(
              // flex: 요소 하나가 차지할 수 있는 비율을 의미한다.
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  formatSeconds(totalSeconds),
                  style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 89,
                      fontWeight: FontWeight.w600),
                ),
              )),
          Flexible(
            flex: 1,
            child: Container(
              child: Center(
                child: IconButton(
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                  icon: Icon(isRunning
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline),
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Center(
                child: IconButton(
                  onPressed: onRestartPressed,
                  icon: Icon(Icons.restart_alt_outlined),
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50), // 왼쪽 상단
                          topRight: Radius.circular(50), // 오른쪽 상단
                          bottomLeft: Radius.zero, // 왼쪽 하단 (직선)
                          bottomRight: Radius.zero, // 오른쪽 하단 (직선)
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "POMODOROS",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            " 🍅 $totalPomodoros",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color,
                                fontSize: 60,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
