import 'package:Taskz/Database/DatabaseHelper.dart';
import 'package:Taskz/Models/Utils.dart';
import 'package:Taskz/Screens/LoginScreen.dart';
import 'package:Taskz/UI/Colors.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/SplashScreen.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(
      const AssetImage("assets/analytics.png"),
      context
    );
    precacheImage(
      const AssetImage("assets/growth.png"),
      context
    );
    precacheImage(
      const AssetImage("assets/annoyedwaiting.png"),
      context
    );
    var clr = PersonalColors();
    return ChangeNotifierProvider(
      create: (context) => Utils(),
      child: AdaptiveTheme(
        //Theme clair
        light: ThemeData(
          brightness: Brightness.light,

          primarySwatch: Colors.amber,
          primaryColor: clr.bleuFonce,
          backgroundColor: clr.blanc,

          //Scaffold
          scaffoldBackgroundColor: clr.blanc,

          fontFamily: 'Montserrat',
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: clr.bleuFonce),
            headline2: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: clr.rouge),
            headline3: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: clr.orange),   
            headline4: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: clr.bleuFonce),
            // headline5: ,
            // headline6: ,

            bodyText1: TextStyle(fontSize: 16.0, color: clr.bleuFonce),
            bodyText2: TextStyle(fontSize: 16.0, color: clr.blanc), 

            caption: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: clr.blanc),
            // overline: 

          ),

          // Floating button
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: clr.bleuFonce,
            foregroundColor: clr.blanc,
          ),

          // Text button theme
          // textButtonTheme: TextButtonThemeData(
          //   style: TextButton.styleFrom(
          //     backgroundColor: clr.bleuFonce,
          //     primary: clr.blanc
          //   ),
          // ),

          // AppBar
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: clr.blanc,
            iconTheme: IconThemeData(
              color: clr.bleuFonce,
              size: 25
            ),
          ),

          //Drawer
          drawerTheme: DrawerThemeData(
            backgroundColor: clr.blanc
          ),

          //Divider
          dividerTheme: DividerThemeData(
            color: clr.rouge,
            thickness: 5,
          ),

          //Card
          cardTheme: CardTheme(
            // color: clr.bleuFonce,
            shadowColor: clr.bleuFonce,
            elevation: 2
          ),

          //Checkbox
          // checkboxTheme: CheckboxThemeData(
          //   fillColor: MaterialStateProperty.all(clr.orange),
          //   checkColor: MaterialStateProperty.all(clr.bleuFonce),
          // ),


          
        ),
        
        dark: ThemeData(
          brightness: Brightness.dark,

          primarySwatch: Colors.amber,
          primaryColor: clr.blanc,
          backgroundColor: clr.bleuFonce,

          //Scaffold
          scaffoldBackgroundColor: clr.bleuFonce,

          fontFamily: 'Montserrat',
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: clr.blanc),
            headline2: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: clr.orange),
            headline3: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: clr.bleuFonce),
            headline4: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: clr.blanc),
            // headline4: ,
            // headline5: ,
            // headline6: ,

            bodyText1: TextStyle(fontSize: 16.0, color: clr.blanc),
            bodyText2: TextStyle(fontSize: 16.0, color: clr.bleuFonce),

            caption: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: clr.bleuFonce),
            // overline: 

          ),

          // Floating button
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: clr.rouge,
            foregroundColor: clr.blanc
          ),

          
          // Text button theme
          // textButtonTheme: TextButtonThemeData(
          //   style: TextButton.styleFrom(
          //     backgroundColor: clr.orange,
          //     primary: clr.bleuFonce
          //   ),
          // ),

          // AppBar
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: clr.bleuFonce,
            iconTheme: IconThemeData(
              color: clr.blanc,
              size: 25
            ),
          ),

          //Drawer
          drawerTheme: DrawerThemeData(
            backgroundColor: clr.bleuFonce,
          ),

          //Divider
          dividerTheme: DividerThemeData(
            color: clr.orange,
            thickness: 5,
          ),

          //Card
          cardTheme: CardTheme(
            // color: clr.blanc,
            // shadowColor: clr.blanc ,
            elevation: 2
          ),

          // //Checkbox
          // checkboxTheme: CheckboxThemeData(
          //   fillColor: MaterialStateProperty.all(clr.bleuFonce),
          //   checkColor: MaterialStateProperty.all(clr.orange),
          // ),


        ),

        initial: AdaptiveThemeMode.light,
        
        builder: (theme, darkTheme) => MaterialApp(
          title: '2Do',
          theme: theme,
          darkTheme: darkTheme,
          // home: LoginScreen(),
          home: SplashScreen(),
        )
      ),
    );
  }
}

