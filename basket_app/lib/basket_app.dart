// ignore_for_file: prefer_const_constructors

import 'package:basket_app/core/constant/color.dart';
import 'package:flutter/material.dart';

class BasketAppScreen extends StatefulWidget {
  const BasketAppScreen({super.key});

  @override
  State<BasketAppScreen> createState() => _BasketAppScreenState();
}

class _BasketAppScreenState extends State<BasketAppScreen> {
  late int scoreX;
  late int scoreY;

  @override
  void initState() {
    super.initState();
    scoreX = 0;
    scoreY = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.primary,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: colon("x")),
                line(),
                Expanded(child: colon("y")),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column btns(String team) {
    // Replace GridView with Column for vertical arrangement
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4), // Adjust vertical spacing
          child: ElevatedButton(onPressed: (){
            setState(() {
              team == "x" ? scoreX += index+1:scoreY +=index+1; 
            });
          }, child: Text("Add +${index+1} of Goals", style: TextStyle(fontSize: 15))), // Adjust font size if needed
        );
      }),
    );
  }

  colon(String s) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(16),
          child: Text(
            s == "x" ? "$scoreX" : "$scoreY",
            style: TextStyle(fontSize: 80),
          ),
        ),
        SizedBox(
          height: 400,
          child: btns(s),
        ),
      ],
    );
  }

  Container line() {
    return Container(
      width: 2,
      height: 600,
      color: Colors.grey,
      margin: EdgeInsets.all(16),
    );
  }
}
