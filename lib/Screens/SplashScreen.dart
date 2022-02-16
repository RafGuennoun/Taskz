import 'dart:async';

import 'package:Taskz/UI/Colors.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'HomeScreen.dart';
import 'LoginScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  Future check() async {
    
    // instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    String? _key = prefs.getString('username');
    
    if (_key==null) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    Timer(
      Duration(milliseconds: 4000),
      (){
        check();
      } 
    );
  }

  @override
  Widget build(BuildContext context) {
  
    var clr = PersonalColors();

    return Scaffold(

      // appBar: AppBar(
      //   title: Text("Spalsh"),
      // ),
      
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.8,
                height: MediaQuery.of(context).size.width*0.8 ,
                child: TextLiquidFill(
                  text: 'Taskz',
                  waveColor: clr.rouge,
                  // waveColor: Colors.green,
                  boxBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  loadDuration: const Duration(milliseconds: 3000),
                  waveDuration: const Duration(milliseconds: 1500),
                  //boxBackgroundColor: Colors.redAccent,
                  textStyle: const TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber
                  ),
                  boxHeight: 300.0,
                ),
              ),

            ],
          ),
        ) 
      ),
    );
  }
}