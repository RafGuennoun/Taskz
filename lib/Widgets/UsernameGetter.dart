
import 'package:Taskz/UI/Colors.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/HomeScreen.dart';


class UsernameGetter extends StatefulWidget {
  const UsernameGetter({
    Key? key,
  }) : super(key: key);

  @override
  State<UsernameGetter> createState() => _UsernameGetterState();
}

class _UsernameGetterState extends State<UsernameGetter> {

  final _nameController = TextEditingController();

  bool? empty;

  late SharedPreferences prefs;

  
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
  var clr = PersonalColors();

  
  Future initPrefs() async {
    // instance
    prefs = await SharedPreferences.getInstance();
  }

  @override
  initState(){
    // TODO: implement initState
    super.initState();
    getCurrentTheme();
    initPrefs();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();  
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Hey, what's your name",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),

          const SizedBox(height: 30,),

          TextField(
            controller: _nameController,
            // to write directly instead of clicking on the text field
            autofocus: true,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                // borderSide: const BorderSide(color: Colors.grey),
              ),
              labelText: "Name",
              hintText: "Enter your name",
              errorText: empty == true ? 'Please enter a name' : null
            ),
            onChanged: (newText){
              setState(() {
                empty = false;
              });
            },
          ),

          const SizedBox(height: 30,),
          
          Container(
            height: 50,
            padding: EdgeInsets.only(
              left: (MediaQuery.of(context).size.width)*(0.2), 
              right: (MediaQuery.of(context).size.width)*(0.2)
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: darkmode ? clr.orange : clr.bleuFonce,
                primary: darkmode ? clr.bleuFonce : clr.blanc 
              ),
              child: Text(
                "Let's start",
                // style: Theme here,
              ),
              onPressed: () async {

                if (_nameController.text.isEmpty) {
                  print('Empty text');
                  setState(() {
                    empty = true;
                  });
                } else {
                  setState(() {
                    empty = false;
                  });
                  String username = _nameController.text;
                  prefs.setString('username', username);
                  String? un = prefs.getString('username');
                  print('Trying to get name : $un');

                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: (context) => HomeScreen()), 
                    (route) => false
                  );
                }



              }, 
            ),
          ),
        ],
      ),
    );
  }
}

