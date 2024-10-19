import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xo_app/core/color.dart';

class XoApp extends StatefulWidget {
  const XoApp({super.key});

  @override
  State<XoApp> createState() => _XoAppState();
}

class _XoAppState extends State<XoApp> {
  List<String> board = List.filled(9, "");
  final String playerX = "X";
  final String playerO = "O";
  late bool gameEnd;
  late bool xturn;
  late int turn;
  late String currentPlayer;
  late int scoreX;
  late int scoreO;
  
  @override
  void initState() {
    super.initState();
    xturn = Random().nextInt(2) == 1 ? true : false;
    currentPlayer = xturn ? playerX : playerO;
    turn = 0;
    gameEnd = false;
    scoreO = 0;
    scoreX = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.fourth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title(),
            score(),
            Expanded(child: game()),
            btn("New Game"),
            btn("Reset Game"),
          ],
        ),
      ),
    );
  }

  SafeArea title() {
    return SafeArea(
      child: Column(
        children: [
          Text("Tic Tac Toe Game",
              style: TextStyle(fontSize: 35, color: AppColor.white)),
          Container(
            width: 100,
            height: 10,
            color: AppColor.primary,
          )
        ],
      ),
    );
  }

  Row score() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$scoreO",
            style: TextStyle(
              fontSize: 50,
              color: AppColor.white,
            )),
        Text(":",
            style: TextStyle(
              fontSize: 35,
              color: AppColor.white,
            )),
        Text("$scoreX",
            style: TextStyle(
              fontSize: 50,
              color: AppColor.third,
            )),
      ],
    );
  }

  GridView game() {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: 9,
        itemBuilder: (context, index) => InkWell(
              child: box(index),
              onTap: () {
                setState(() {
                  move(index);
                });
              },
            ));
  }

  InkWell btn(String s) {
    return InkWell(
      child: Container(
          color: AppColor.third,
          width: 400,
          height: 50,
          margin: const EdgeInsets.all(3),
          child: Center(
              child: Text(s,
                  style: TextStyle(fontSize: 20, color: AppColor.white)))),
      onTap: () {
        setState(() {
          board = List.filled(9, "");
          gameEnd = false;
          turn = 0;
          if(!s.contains("New")){
          scoreO = 0 ;
          scoreX = 0;
          }
        });
      },
    );
  }

  Container box(int index) {
    return Container(
      width: 500,
      height: 500,
      decoration: BoxDecoration(
        color: AppColor.fourth,
        border: border(index + 1), // Set the color inside BoxDecoration
      ),
      child: Center(
          child: Text(
        board[index],
        style: TextStyle(
            color: board[index] == playerX ? AppColor.third : AppColor.white,
            fontSize: 60,
            fontWeight: FontWeight.bold),
      )),
    );
  }

  Border border(int index) {
    if (index == 7) {
      return Border(
        right: BorderSide(color: AppColor.primary, width: 3),
      );
    }
    if (index == 1 || index == 4) {
      return Border(
        right: BorderSide(color: AppColor.primary, width: 3),
        bottom: BorderSide(color: AppColor.primary, width: 5), // Right border
      );
    }
    if (index == 7 || index == 8 || index == 9) {
      return Border(
        left: BorderSide(color: AppColor.primary, width: 3),
      );
    }
    if (index % 3 == 0) {
      return Border(
        left: BorderSide(color: AppColor.primary, width: 3), // Left border
        bottom: BorderSide(color: AppColor.primary, width: 5),
      );
    }

    return Border(
      left: BorderSide(color: AppColor.primary, width: 3), // Left border
      right: BorderSide(color: AppColor.primary, width: 3),
      bottom: BorderSide(color: AppColor.primary, width: 5), // Right border
    );
  }

  void _checkWinner() {
    List<List<int>> winSituations = [
      // Horizontal Wins
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],

      // Vertical Wins
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],

      // Diagonal Wins
      [0, 4, 8],
      [2, 4, 6],
    ];
    if (!gameEnd) {
      for (var element in winSituations) {
        String one = board[element[0]];
        String two = board[element[1]];
        String tre = board[element[2]];

        if (one.isNotEmpty && two.isNotEmpty && tre.isNotEmpty) {
          if (one == two && two == tre) {
            showGameOverMsg("player $currentPlayer Won!");
            gameEnd = true;
            return;
          }
        }
      }
      if (turn >= 9) {
        showGameOverMsg("Tie !");
        gameEnd = true;
        return;
      }
    }
  }

  void switchPlayer() {
    if (!gameEnd) {
      currentPlayer = xturn ? playerO : playerX;
      xturn = !xturn;
    }
  }

  void showGameOverMsg(String txt) {
    if(txt.toLowerCase().contains("won") ){
      if(currentPlayer == playerX){
        setState(() {
          ++scoreX;
        });
      }else{
        setState(() {
          ++scoreO;
        });
      }
    }
  }

  void move(int index) {
    String space = board[index];
    if (space.isEmpty && !gameEnd) {
      ++turn;
      setState(() {
        board[index] = currentPlayer;
       _checkWinner();
        switchPlayer();
      });
    }
  }
}
