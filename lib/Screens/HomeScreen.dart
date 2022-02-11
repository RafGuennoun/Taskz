import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:basic_utils/basic_utils.dart';
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

    final myList = <String>['Buisness', 'Univ', 'Gym'];


    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          'Taskz',
          style: Theme.of(context).textTheme.headline2,
        ),
        centerTitle: true,
        actions: [
         
          IconButton(
            icon: Icon(Icons.search, color: Colors.blueGrey, size: 25,),
            onPressed: (){
              print("Search from app bar clicked");
            }, 
          ),
        ],
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

      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 20, left: 25),
              child: RichText(
                text: TextSpan(
                  text: "What's up, ",
                  style: Theme.of(context).textTheme.headline1,
                children: [
                  TextSpan(
                  text: "${StringUtils.capitalize(username.toString())} ",
                    style: Theme.of(context).textTheme.headline3,
                  ),

                  TextSpan(
                  text: '!',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ]
                )
              ),
            ),

            SizedBox(height: 15,),
            Divider(),
            SizedBox(height: 15,),

            //Categories
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.4,
              // color: Colors.greenAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'CATEGORIES',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.2,
                      // color: Colors.orangeAccent,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: myList.length,
                        itemBuilder: (BuildContext context,int index){
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              width: 220,
                              // height: 50,
                              // color: Colors.greenAccent,
                              padding: const EdgeInsets.only(left: 20,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                // color: Colors.greenAccent,
                                color: Theme.of(context).backgroundColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  Text(
                                    '   ${myList.length} Tasks',
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),


                                  Text(
                                    '${myList[index]}',
                                    style: Theme.of(context).textTheme.headline4,
                                  ),

                                  Text(
                                    '2',
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      )
                    ),
                  )


                ],
              ),
            )


          ],
        )
      ),

      /*
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
      */


    );
  }
}

