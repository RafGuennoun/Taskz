import 'dart:async';

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

  bool darkmode = false;
  dynamic savedThemeMode;

  Future getCurrentTheme() async {
    savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode.toString() == 'AdaptiveThemeMode.dark') {
      print('mode sombre');
      setState(() {
        darkmode = true;
      });
    } else {
      setState(() {
        darkmode = false;
      });
      print('mode clair');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentTheme();
    
    Timer(
      Duration(milliseconds: 4000),
      (){
        check();
      } 
    );
  }

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      
      //backgroundColor: Colors.blueGrey,
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
                  waveColor: darkmode ? Colors.amber : Colors.redAccent,
                  boxBackgroundColor: Theme.of(context).primaryColor,
                  loadDuration: Duration(milliseconds: 3000),
                  waveDuration: Duration(milliseconds: 1500),
                  //boxBackgroundColor: Colors.redAccent,
                  textStyle: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber
                  ),
                  boxHeight: 300.0,
                ),
              )

            
            ],
          ),
        ) 
      ),
    );
  }
}