import 'package:flutter/material.dart';
import 'package:splash/core/colors.dart';

class Splash extends StatefulWidget{
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), (){
      Navigator.pushReplacementNamed(context, "/");
    });
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          color: AppColor.bg,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("splash/assets/logo.jpg"),
                const SizedBox(
                  height: 100,
                ),
                const CircularProgressIndicator(color: Colors.white,)
              ],
            ),
          ),
        ),
      );
  }
}