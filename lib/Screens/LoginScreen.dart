import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../Widgets/UsernameGetter.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
  }

  // final _nameController = TextEditingController();

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _nameController.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    bool dark = darkmode;
    return Scaffold(

      // backgroundColor: Colors.amberAccent,

      // appBar: AppBar(
      //   title: const Text(
      //     'Tasks',
      //     style: TextStyle(
      //       fontFamily: 'Montserrat',
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.blueGrey
      //     )
      //   ),
      //   // elevation: 0,
      //   // backgroundColor: Colors.amberAccent ,
      // ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              FadeInUp(
                duration: Duration(milliseconds: 800) ,
                child: RichText(
                  text: TextSpan(
                    text: 'Manage your\nteam & evething \nwith ',
                    style: Theme.of(context).textTheme.headline1,
                  children: [
                    TextSpan(
                    text: 'Taskz',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ]
                  )

                ),
              ),


              FadeInLeftBig(
                duration: Duration(milliseconds: 800) ,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/bighead.png', fit: BoxFit.fill,),
                ),
              ),

            ],
          ),
        ) 
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: (){
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

          // Navigator.push(
          //   context, 
          //   MaterialPageRoute(builder: (context) => HomeScreen())
          // );
        }
      ),
      
    );
  }
}
