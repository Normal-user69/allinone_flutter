import 'package:flutter/material.dart';
import 'package:lighter_app/core/constant/color.dart';

class LighterScreen extends StatefulWidget {
  const LighterScreen({super.key});

  @override
  State<LighterScreen> createState() => _LighterScreenState();
}

class _LighterScreenState extends State<LighterScreen> {
  bool switcher = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.primary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //lightbulb on
              lightBulb(),
              lightSwitch(),
            ],
          ),
        ),
      ),
    );
  }

  Container lightSwitch() {
    return Container(
        width: 110,
        height: 45,
        margin: const EdgeInsets.only(top: 20.0),
        decoration: btnDecoration(),
        child: text());
  }
  
  BoxDecoration btnDecoration() {
    return BoxDecoration(
          color: AppColor.green,
          borderRadius: BorderRadius.circular(5),
          boxShadow: List<BoxShadow>.filled(
              1,
              const BoxShadow(
                  spreadRadius: BorderSide.strokeAlignInside, blurRadius: 2)),
        );
  }
  
  InkWell text() {
    return InkWell(
      onTap: (){
        setState(() {
        switcher = !switcher;
        });
      },
      child: const Center(
            child: Text(
              "On",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
    );
  }
  
  Icon lightBulb() {
    return Icon(Icons.lightbulb,
    size: 100,
    color: switcher ? AppColor.bg:AppColor.white,
    
    );

  }
}
