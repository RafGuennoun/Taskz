import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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

  // late SharedPrefs prefs;
  late SharedPreferences prefs;
  
  Future initPrefs() async {
    // instance
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentTheme();
    initPrefs();
  }

  late String? username = prefs.getString('username');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          'Taskz',
          style: Theme.of(context).textTheme.headline2,
        ),
        centerTitle: true,
      ),

      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [

              Text(
                'Taskz',
                style: Theme.of(context).textTheme.headline3,
              ),

              const SizedBox(height: 15,),
              Divider(),
              const SizedBox(height: 35,),

              SwitchListTile(
                title: Text('Dark mode'),
                value: darkmode,
                activeColor: Colors.orange,
                onChanged: (bool value) {
                  print(value);
                  if (value == true) {
                    AdaptiveTheme.of(context).setDark();
                  } else {
                    AdaptiveTheme.of(context).setLight();
                  }
                  setState(() {
                    darkmode = value;
                  });
                },
                secondary: const Icon(Icons.nightlight_round),
              ),
            ],
          ),
        ),
      ),

      

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Text(
              'Welcome $username',
              style: Theme.of(context).textTheme.headline1,
            ),

            SizedBox(height: 150,),

            ElevatedButton(
              child: Text('Delete'),
              onPressed: (){
                prefs.remove('username');
                Navigator.pushAndRemoveUntil(
                  context, 
                  MaterialPageRoute(builder: (context) => LoginScreen()), 
                  (route) => false
                );
                print('Delete usenrame');
              }, 
            ),
          ],
        ),
      ),
    );
  }
}