import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
/* import 'package:math_expressions/math_expressions.dart';
 */
class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  late String equ;
  late String result;
  late bool fraction;
  @override
  void initState() {
    super.initState();
    equ = "";
    result = "0";
    fraction = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body:  Column(
          children: [
          Expanded(
            flex: 1,
            child: screen()),
          Expanded(
            flex: 2,
            child: btns()),
          ],
        ),
    );
  }

  Widget btns() {
    List<String> btns = [
      "C",
      "+/-",
      "%",
      "DEL",
      "7",
      "8",
      "9",
      "/",
      "4",
      "5",
      "6",
      "x",
      "1",
      "2",
      "3",
      "-",
      "0",
      ".",
      "=",
      "+",
    ];
    return Container(
      color: Colors.black,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: btns.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: btn(btns, index),
            onTap: () {
              setState(() {
                if (btns[index].contains(RegExp(r"[0-9]"))) {
                  equ += btns[index];
                } else if ((index + 1) % 4 == 0 && (index + 1) != 4) {
                  equ += btns[index];
                }else if(btns[index].contains("C")){
                  equ = "";
                  result = "0";
                  fraction = false;
                }else if(btns[index].contains("DEL")){
                  equ =equ.isNotEmpty ? equ.substring(0,equ.length-1) : "";
                }else if(index == 18){
                  result = "${double.parse(evaluateExpression(equ).toStringAsFixed(8))}";
                  equ = "";
                  fraction = false;
                }else if (index == 17){
                  if(!fraction){
                  equ += btns[index];
                  fraction = true;
                }
              }
              });
            },
          );
        },
      ),
    );
  }

  btn(List btns, index) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: color(index),
      ),
      child: Center(
        child: Text(
          btns[index],
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Color color(int index) {
    if (index < 4 || index == 3) {
      return Colors.cyan.shade50;
    }
    if ((index + 1) % 4 == 0) {
      return Colors.lightBlue;
    }
    if (index == 18) {
      return Colors.orange;
    }
    return Colors.white;
  }

  AppBar appbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text("Calculator"),
      backgroundColor: Colors.blue,
    );
  }

  Container screen() {
    return Container(
      width: double.infinity,
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  equ,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Align result to the right
            children: [
              Padding(
                padding: const EdgeInsets.all(
                    16.0), // Add padding for better spacing
                child: Text(
                  result,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double evaluateExpression(String expression) {
    Parser p = Parser();
    Expression exp = p.parse(expression.replaceAll('x', '*')); // Replace 'x' with '*' for multiplication
    ContextModel cm = ContextModel();
    return exp.evaluate(EvaluationType.REAL, cm);
  }

}
