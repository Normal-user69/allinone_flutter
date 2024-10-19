import 'package:flutter/material.dart';
import 'package:workshop/core/constants/colors.dart';
import 'package:workshop/core/routes/routes_name.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page',
      style: TextStyle(
        color: AppColor.white
      ),
      ),
      backgroundColor: AppColor.black,
      ),
      backgroundColor: Colors.blue,
      
      body: SafeArea(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            Expanded(child: starterAppItems())
        ],
      ),
      )),
    );
  }

  GridView starterAppItems(){
    var routes = RoutesName.appRoutes;
    int length = routes.length-2;

    return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      childAspectRatio: 2,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
    ),
    itemCount: length,
    itemBuilder: (context , index){
        String name = routes.keys.elementAt(index+2);
        String src = "lib/assets/${routes[name]!}";
        return Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
          color: AppColor.btn,
          borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(src , width: 100,height: 100,),
              Text(name.replaceAll("/", "") , style: const TextStyle(
                fontSize: 20,
                color: Colors.white
              ) ),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  textStyle: WidgetStatePropertyAll(TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
                ),
                onPressed: (){
                Navigator.pushNamed(context, name);
              }
              , child: const Text("▶" , style: TextStyle(color: Colors.white),)
              ),
            ],
          ),
        );
    });
  }
}