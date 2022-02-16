import 'package:Taskz/Screens/HomeScreen.dart';
import 'package:Taskz/UI/Colors.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../Widgets/UsernameGetter.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var clr = PersonalColors();

  @override
  Widget build(BuildContext context) {

    Widget buildImage(String path){
      return Center(
        child: Image.asset(path, width: 350,) ,
      );
    }

    PageDecoration getPageDecoration(){
      return PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: clr.bleuFonce),

        bodyTextStyle: TextStyle(fontSize: 16, color: clr.bleuFonce),

        bodyPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: const EdgeInsets.all(24),
        pageColor: clr.blanc
      );
    }

    DotsDecorator getDotsDecoration(){
      return DotsDecorator(
        color: Colors.grey,
        size: const Size(10,10),
        activeColor: clr.bleuFonce,
        activeSize: const Size(25, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24)
        )
      );
    }

    return SafeArea(
        child: IntroductionScreen(
          pages: [

            PageViewModel(
              title: 'Bring structure\n to your day',
              body: 'Using Taskz will help to optimize the structure of your working day and be more productive',
              image: buildImage("assets/analytics.png"),
              decoration: getPageDecoration()
            ), 

            PageViewModel(
              title: 'Set your priorities',
              body: "With Taskz, you can list down your to-do list, so you have one view of all that you have on your plate",
              image: buildImage("assets/growth.png"),
              decoration: getPageDecoration(),
            ),

            PageViewModel(
              title: "Don't lose\n your task list",
              body: "Have you ever lost your to do list? It's a real pain! It interrupts your work flow. Use Taskz, everything is saved for you",
              image: buildImage("assets/annoyedwaiting.png"),
              decoration: getPageDecoration()
            ),
          ],
          done: const Text(
            'Start',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 18,
              fontWeight: FontWeight.bold
              ),
          ),
          onDone: (){
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(builder: (context) => HomeScreen())
            // );


            showModalBottomSheet(
              // so the keybord can't hide the bottomsheet
              isScrollControlled: true,
              context: context, 
              builder: (context) => 
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom
                    ),
                    
                    child: UsernameGetter() 
                  ),
                ) 
            );
          },
          showSkipButton: true,
          skip: const Text(
            "Skip",
            style: TextStyle(
              color: Colors.blueGrey,
              // fontSize: 18,
              // fontWeight: FontWeight.bold
            ),
          ),
          dotsDecorator: getDotsDecoration(),
          // globalBackgroundColor: darkmode ? clr.bleuFonce : clr.blanc,
          globalBackgroundColor: clr.blanc,
          showNextButton: false,
        ),
  
      );

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.play_arrow),
      //   onPressed: (){
      //     showModalBottomSheet(
      //       // so the keybord can't hide the bottomsheet
      //       isScrollControlled: true,
      //       context: context, 
      //       builder: (context) => 
      //         SingleChildScrollView(
      //           child: Container(
      //             padding: EdgeInsets.only(
      //               bottom: MediaQuery.of(context).viewInsets.bottom
      //             ),
                  
      //             child: UsernameGetter() 
      //           ),
      //         ) 
      //     );

      //   }
      // ),
      
  }
}
