
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

  bool empty =true;

  late SharedPreferences prefs;
  
  Future initPrefs() async {
    // instance
    prefs = await SharedPreferences.getInstance();
  }

  @override
  initState(){
    // TODO: implement initState
    super.initState();
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
      color:Theme.of(context).primaryColor,
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Hey, what's your name",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),

          SizedBox(height: 30,),

          TextField(
            controller: _nameController,
            // to write directly instead of clicking on the text field
            autofocus: true,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: "Name",
              hintText: "Enter your name",
              errorText: empty == true ? 'Please enter a name' : null
            ),
            onChanged: (newText){
              
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
              child: Text("Let's start"),
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

