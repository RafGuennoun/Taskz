import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'Screens/SplashScreen.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return AdaptiveTheme(
      //Theme clair
      light: ThemeData(
        brightness: Brightness.light,

        primarySwatch: Colors.amber,
        primaryColor: Color(0xFFf1f5f5),

        //Scaffold
        scaffoldBackgroundColor: Color(0xFFf1f5f5),

        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.blueGrey),
          headline2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blueGrey),
          headline3: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.redAccent),
          // headline2: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
          bodyText1: TextStyle(fontSize: 16.0, color: Colors.blueGrey),
        ),

        // Floating button
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.redAccent,
          foregroundColor: Color(0xFFf1f5f5)
        ),

        // Text button theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.redAccent,
            primary: Color(0xFFf1f5f5)
          ),
        ),

        // AppBar
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          //elevation: 0,
          foregroundColor: Colors.blueGrey,
          backgroundColor: Colors.amber,
          iconTheme: IconThemeData(
            color: Colors.blueGrey,
          ),
        ),

        
      ),
      dark: ThemeData(
        brightness: Brightness.dark,

        primarySwatch: Colors.amber,
        primaryColor: Color(0xFF191919),

        //Scaffold
        scaffoldBackgroundColor: Color(0xFF191919),

        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Color(0xFFf1f5f5)),
          headline3: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.amber),
          headline2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0xFFf1f5f5)),
          bodyText1: TextStyle(fontSize: 16.0, color:Color(0xFFf1f5f5)),
        ),

        // Floating button
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.amber,
          foregroundColor: Color(0xFF191919)
        ),

        
        // Text button theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.amber,
            primary: Colors.blueGrey
          ),
        ),

        // AppBar
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          //elevation: 0,
          foregroundColor: Colors.amber,
          backgroundColor: Colors.blueGrey,
          iconTheme: IconThemeData(
            color: Color(0xFFf1f5f5),
          ),
        ),


      ),

      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        title: '2Do',
        theme: theme,
        darkTheme: darkTheme,
        // home: SplashScreen(),
        home: SplashScreen(),
      )
    );
  }
}




//  return MaterialApp(
//       title: '2Do',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // home: SplashScreen(),
//       home: SplashScreen(),
//     );