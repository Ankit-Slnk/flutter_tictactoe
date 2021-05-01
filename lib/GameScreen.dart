import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tictactoe/Circle.dart';
import 'package:tictactoe/Cross.dart';
import 'package:tictactoe/Line.dart';
import 'package:tictactoe/Utility.dart';
import 'package:velocity_x/velocity_x.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  List<int> selectedX = [];
  List<int> selectedO = [];
  bool isXTurn = true;
  bool isXWin = false;
  bool isOWin = false;
  bool isDraw = false;
  int scoreX = 0;
  int scoreO = 0;
  int scoreDraw = 0;
  int from = -1;
  int to = -1;
  Timer _timer;
  int _start = 3;
  bool isTimer = false;
  AnimationController _controller;
  Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
      value: 0.1,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: SafeArea(
        child: Column(
          children: [
            appBarView(),
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 10,
              ),
              child: Row(
                children: [
                  player1View(),
                  drawView(),
                  player2View(),
                ],
              ),
            ),
            Utility.getTextView(
              "Round - ${scoreX + scoreO + scoreDraw + 1}",
              22,
            ),
            SizedBox(
              height: 40,
            ),
            board(),
          ],
        ),
      ),
    );
  }

  Widget drawView() {
    return Expanded(
      child: Column(
        children: [
          Utility.getTextView("Draw", 16),
          Utility.getTextView(scoreDraw.toString(), 18),
          SizedBox(
            height: 16,
          ),
          Container(height: 10, width: 10, color: Colors.transparent)
        ],
      ),
    );
  }

  Widget player2View() {
    return Expanded(
      child: Column(
        children: [
          Neumorphic(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Column(
              children: [
                Utility.getTextView2("Player 2", 17),
                SizedBox(
                  height: 8,
                ),
                Utility.getTextView2("O - $scoreO", 23),
              ],
            ),
            style: Utility.getNeumorphicStyle(
              shape: NeumorphicShape.concave,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: isXTurn ? Colors.transparent : Colors.black,
              borderRadius: BorderRadius.circular(50),
            ),
            child: isXTurn
                ? Container()
                : Neumorphic(
                    style: Utility.getNeumorphicStyle(
                      shape: NeumorphicShape.concave,
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget player1View() {
    return Expanded(
      child: Column(
        children: [
          Neumorphic(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Column(
              children: [
                Utility.getTextView2("Player 1", 17),
                SizedBox(
                  height: 8,
                ),
                Utility.getTextView2("X - $scoreX", 23),
              ],
            ),
            style: Utility.getNeumorphicStyle(
              shape: NeumorphicShape.concave,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: isXTurn ? Colors.black : Colors.transparent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: isXTurn
                ? Neumorphic(
                    style: Utility.getNeumorphicStyle(
                      shape: NeumorphicShape.concave,
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  Widget appBarView() {
    return Container(
      padding: EdgeInsets.only(
        right: 20,
        left: 20,
        top: 10,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Utility.getTextView("Tic Tac Toe", 30),
          Container(
            alignment: Alignment.centerRight,
            child: NeumorphicButton(
              child: Container(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.refresh_rounded,
                  color: Colors.white,
                ),
              ),
              style: Utility.getNeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              onPressed: () {
                reset();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget board() {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Container(
            height: context.screenWidth > 600
                ? 300
                : MediaQuery.of(context).size.width / 2,
            width: context.screenWidth > 600
                ? 300
                : MediaQuery.of(context).size.width / 2,
            color: Colors.black,
          ),
          Container(
            height: context.screenWidth > 600
                ? 600
                : MediaQuery.of(context).size.width,
            width: context.screenWidth > 600
                ? 600
                : MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      boxView(0),
                      boxView(1),
                      boxView(2),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      boxView(3),
                      boxView(4),
                      boxView(5),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      boxView(6),
                      boxView(7),
                      boxView(8),
                    ],
                  ),
                ),
              ],
            ),
          ),
          from == -1 && to == -1
              ? Container()
              : Container(
                  padding: EdgeInsets.all((context.screenWidth > 600
                          ? 600
                          : MediaQuery.of(context).size.width) /
                      6),
                  height: context.screenWidth > 600
                      ? 600
                      : MediaQuery.of(context).size.width,
                  width: context.screenWidth > 600
                      ? 600
                      : MediaQuery.of(context).size.width,
                  child: Line(
                    from: from,
                    to: to,
                  ),
                ),
          !isTimer
              ? Container()
              : Container(
                  height: context.screenWidth > 600
                      ? 600
                      : MediaQuery.of(context).size.width,
                  width: context.screenWidth > 600
                      ? 600
                      : MediaQuery.of(context).size.width,
                  color: Colors.white.withOpacity(0.9),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Utility.getTextView("Next round starts in", 30),
                      Utility.getTextView(_start.toString(), 100),
                    ],
                  ),
                ),
          isDraw
              ? Container(
                  height: context.screenWidth > 600
                      ? 600
                      : MediaQuery.of(context).size.width,
                  width: context.screenWidth > 600
                      ? 600
                      : MediaQuery.of(context).size.width,
                  color: Colors.white.withOpacity(0.9),
                  alignment: Alignment.center,
                  child: ScaleTransition(
                    scale: _animation,
                    alignment: Alignment.center,
                    child: Utility.getTextView("Game is Draw !!!", 40),
                  ),
                )
              : Container(),
          if (isXWin)
            Container(
              height: context.screenWidth > 600
                  ? 600
                  : MediaQuery.of(context).size.width,
              width: context.screenWidth > 600
                  ? 600
                  : MediaQuery.of(context).size.width,
              color: Colors.white.withOpacity(0.9),
              alignment: Alignment.center,
              child: ScaleTransition(
                scale: _animation,
                alignment: Alignment.center,
                child: Utility.getTextView("X is Winner !!!", 40),
              ),
            ),
          if (isOWin)
            Container(
              height: context.screenWidth > 600
                  ? 600
                  : MediaQuery.of(context).size.width,
              width: context.screenWidth > 600
                  ? 600
                  : MediaQuery.of(context).size.width,
              color: Colors.white.withOpacity(0.9),
              alignment: Alignment.center,
              child: ScaleTransition(
                scale: _animation,
                alignment: Alignment.center,
                child: Utility.getTextView("O is Winner !!!", 40),
              ),
            )
        ],
      ),
    );
  }

  Widget boxView(int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          if (!isXWin && !isOWin) {
            if (isXTurn) {
              //if x turn
              if (!selectedO.contains(index) && !selectedX.contains(index)) {
                //check is box marked with x or o
                isXTurn = !isXTurn;
                selectedX.add(index);
                checkIsWin();
                notify();
              }
            } else {
              //if o turn
              if (!selectedO.contains(index) && !selectedX.contains(index)) {
                //check is box marked with x or o
                isXTurn = !isXTurn;
                selectedO.add(index);
                checkIsWin();
                notify();
              }
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: Utility.getBorderRadius(index, 20),
          ),
          child: Container(
            alignment: Alignment.center,
            decoration: Utility.decoration(index),
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: selectedO.contains(index)
                  ? Circle()
                  : selectedX.contains(index)
                      ? Cross()
                      : Container(),
            ),
          ),
        ),
      ),
    );
  }

  notifyChanges(int _from, int _to, bool _isXWin, bool _isOWin) async {
    //wait for x or o animation to complete
    await Future.delayed(Duration(seconds: 1));
    //from and to for line animation
    from = _from;
    to = _to;
    notify();
    //wait for line animation to complete
    await Future.delayed(Duration(seconds: 1));
    //set who is winner
    isXWin = _isXWin;
    isOWin = _isOWin;
    notify();
    //increase score
    increaseScore();
  }

  checkIsWin() async {
    //check X
    if (selectedX.contains(0) &&
        selectedX.contains(1) &&
        selectedX.contains(2)) {
      notifyChanges(0, 2, true, false);
    } else if (selectedX.contains(3) &&
        selectedX.contains(4) &&
        selectedX.contains(5)) {
      notifyChanges(3, 5, true, false);
    } else if (selectedX.contains(6) &&
        selectedX.contains(7) &&
        selectedX.contains(8)) {
      notifyChanges(6, 8, true, false);
    } else if (selectedX.contains(0) &&
        selectedX.contains(3) &&
        selectedX.contains(6)) {
      notifyChanges(0, 6, true, false);
      await Future.delayed(Duration(seconds: 1));
    } else if (selectedX.contains(1) &&
        selectedX.contains(4) &&
        selectedX.contains(7)) {
      notifyChanges(1, 7, true, false);
    } else if (selectedX.contains(2) &&
        selectedX.contains(5) &&
        selectedX.contains(8)) {
      notifyChanges(2, 8, true, false);
    } else if (selectedX.contains(0) &&
        selectedX.contains(4) &&
        selectedX.contains(8)) {
      notifyChanges(0, 8, true, false);
    } else if (selectedX.contains(2) &&
        selectedX.contains(4) &&
        selectedX.contains(6)) {
      notifyChanges(2, 6, true, false);
    }

    //check O
    else if (selectedO.contains(0) &&
        selectedO.contains(1) &&
        selectedO.contains(2)) {
      notifyChanges(0, 2, false, true);
    } else if (selectedO.contains(3) &&
        selectedO.contains(4) &&
        selectedO.contains(5)) {
      notifyChanges(3, 5, false, true);
    } else if (selectedO.contains(6) &&
        selectedO.contains(7) &&
        selectedO.contains(8)) {
      notifyChanges(6, 8, false, true);
    } else if (selectedO.contains(0) &&
        selectedO.contains(3) &&
        selectedO.contains(6)) {
      notifyChanges(0, 6, false, true);
    } else if (selectedO.contains(1) &&
        selectedO.contains(4) &&
        selectedO.contains(7)) {
      notifyChanges(1, 7, false, true);
    } else if (selectedO.contains(2) &&
        selectedO.contains(5) &&
        selectedO.contains(8)) {
      notifyChanges(2, 8, false, true);
    } else if (selectedO.contains(0) &&
        selectedO.contains(4) &&
        selectedO.contains(8)) {
      notifyChanges(0, 8, false, true);
    } else if (selectedO.contains(2) &&
        selectedO.contains(4) &&
        selectedO.contains(6)) {
      notifyChanges(2, 6, false, true);
    }
    //DRAW
    else {
      if (selectedX.length + selectedO.length == 9) {
        await Future.delayed(Duration(seconds: 1));
        isDraw = true;
        notify();
        //increase score
        increaseScore();
      }
    }
  }

  increaseScore() async {
    if (isXWin) {
      _controller.forward();
      scoreX++;
      await Future.delayed(Duration(seconds: 3));
      startTimer();
      if (scoreX == 100) {
        reset();
      }
    } else if (isOWin) {
      _controller.forward();
      scoreO++;
      await Future.delayed(Duration(seconds: 3));
      startTimer();
      if (scoreO == 100) {
        reset();
      }
    } else if (isDraw) {
      _controller.forward();
      scoreDraw++;
      await Future.delayed(Duration(seconds: 3));
      startTimer();
      if (scoreDraw == 100) {
        reset();
      }
    }
  }

  reset() {
    playNextRound();
    scoreX = 0;
    scoreO = 0;
    scoreDraw = 0;
    notify();
  }

  playNextRound() {
    selectedX.clear();
    selectedO.clear();
    isXWin = false;
    isOWin = false;
    isDraw = false;
    isXTurn = true;
    from = -1;
    to = -1;
    notify();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    isTimer = true;
    playNextRound();
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (_start == 1) {
          isTimer = false;
          timer.cancel();
          _start = 3;
          _controller.reset();
          notify();
        } else {
          _start--;
          notify();
        }
      },
    );
  }

  @override
  void dispose() {
    try {
      _timer.cancel();
    } catch (e) {}
    _controller.dispose();
    super.dispose();
  }

  notify() {
    if (mounted) setState(() {});
  }
}

//winning combinations
//
// HORIZONTAL
//
//  0 1 2
//  3 4 5
//  6 7 8
//
//  VERTICAL
//
//  0 3 6
//  1 4 7
//  2 5 8
//
// CROSS
//
//  0 4 8
//  2 4 6
