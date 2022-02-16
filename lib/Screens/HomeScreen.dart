import 'dart:convert';

import 'package:Taskz/Database/DatabaseHelper.dart';
import 'package:Taskz/Models/Category.dart';
import 'package:Taskz/Models/Task.dart';
import 'package:Taskz/Models/Utils.dart';
import 'package:Taskz/UI/Colors.dart';
import 'package:Taskz/Widgets/LoadingData.dart';
import 'package:Taskz/Widgets/NoTasks.dart';
import 'package:Taskz/Widgets/TaskGetter.dart';
import 'package:Taskz/Widgets/WelcomeText.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:basic_utils/basic_utils.dart';




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

  late SharedPreferences prefs;
  
  Future initPrefs() async {
    // instance
    prefs = await SharedPreferences.getInstance();
  }

  Category defaultCategory = Category("Today", '');
  int nbTasksToday = 0;
  int nbDoneTasksToday = 0;

  getWoekPercent() async {
    Utils util = Utils();
    nbTasksToday = util.countTodaysTasks();
    nbDoneTasksToday = util.countTodayDoneTasks();
    int workPercent = (( nbDoneTasksToday *100 ) / nbTasksToday).round();
    // int workPercent = (( util.countTodayDoneTasks() *100 ) / util.countTodaysTasks()).round();
    return workPercent;
  }
   
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentTheme();
    initPrefs();
    DBHelper.instance.existsCategory(defaultCategory.name).then((value) {
      if (value == false) {
        util.addCategory(defaultCategory);
      }
    });


  }


  late String? username = prefs.getString('username');

  Utils util = Utils();
  


  bool _customTileExpanded = false;

  printTask(Task t){
    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    print(t.toMap().toString());
  }



  @override
  Widget build(BuildContext context) {

    var clr = PersonalColors();

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    void _showSnackBar(BuildContext context, String msg){
      final snackBar = SnackBar(content: Text(msg));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }


    return Scaffold(
      
      appBar: AppBar(
        // title: Text(
        //   'Taskz',
        //   style: Theme.of(context).textTheme.headline2,
        // ),
        centerTitle: true,
        actions: [
         
          IconButton(
            // icon: Icon(Icons.search, color: Colors.blueGrey, size: 25,),
            icon: const Icon(Icons.search,),
            onPressed: (){
              print("Search from app bar clicked");
            }, 
          ),

          IconButton(
            // icon: Icon(Icons.search, color: Colors.blueGrey, size: 25,),
            icon: const Icon(Icons.notifications_outlined,),
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
                style: Theme.of(context).textTheme.headline2,
              ),

              const SizedBox(height: 15,),
              const Divider(),
              const SizedBox(height: 35,),

              SwitchListTile(
                title: const Text('Dark mode'),
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
                secondary: Icon(
                  Icons.nightlight_round,
                  color: darkmode ? clr.orange : clr.bleuFonce,
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
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
                  
                  child:  TaskGetter(category: defaultCategory,) 
                ),
              ) 
          );
        }
      ),
      
      body: SafeArea(
        child: Container(
          width: width,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [

              // Welcome text
              WelcomeText(width, height, username!, context),

              // // Work % of the day
              // Container( 
              //   margin: EdgeInsets.only(left: 15, right: 15),
              //   width: width,
              //   height: height*0.2,
              //   // color: clr.rouge,
              //   // child: Placeholder()
              //   child: Row(
              //     children: [
              //       Expanded(
              //         flex: 2,
              //         child: Container(
              //           child: Center(
              //             child: Text("Dir heddaa"),
              //           ),
              //         ) 
              //       ),

              //       Expanded(
              //         child: Container(
              //           color: Colors.grey[800],
              //           child: Center(
              //             child: CircularPercentIndicator(
              //               lineWidth: 12,
              //               radius: 50,
              //               // lineWidth: 13.0,
              //               animation: true,
              //               percent: 0.7,
              //               center: Text(
              //                 getWoekPercent().toString(),
              //                 style:
              //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              //               ),
              //               circularStrokeCap: CircularStrokeCap.round,
              //               progressColor: Colors.blueGrey,
              //             ),
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),

              // SizedBox(height: 15,),

              // Todays tasks
              SizedBox(
                width: width,
                child: FutureBuilder<List<Task>> (
                  // future: DBHelper.instance.allTasks(),
                  // future: util.getAllTasks(),
                  future: util.getTodaysTasks(),
                  builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot){
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                       
                        List<Task>? tasks = snapshot.data; 
                        return NoTasks(width: width, height: height);

                      } else {
                        List<Task>? tasks = snapshot.data;

                        int nbTasks = tasks!.length;
                        int nbDone = 0;
                        for(Task t in tasks)
                        {
                          if (t.done == true) {
                            nbDone ++;
                          }
                        }

                        int per = ((nbDone*100)/nbTasks).round();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // Work % of the day
                            Container( 
                              margin: EdgeInsets.only(left: 25, right: 25),
                              width: width,
                              height: height*0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: darkmode ? clr.bleuGris : clr.bleuFonce,
                              ),
                              // child: Placeholder()
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25, right: 25),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10, right: 25),
                                          child: per == 100 ?
                                          Text(
                                            "Good job, you are done for today ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: darkmode ? clr.blanc : clr.blanc, 
                                              fontSize: 20, 
                                              fontWeight: FontWeight.bold),
                                          )
                                          : per == 0 
                                          ? Text(
                                              "You have to start working",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: darkmode ? clr.blanc : clr.blanc, 
                                                fontSize: 20, 
                                                fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              "Great, your today paln almost done",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: darkmode ? clr.blanc : clr.blanc,  
                                                fontSize: 20, 
                                                fontWeight: FontWeight.bold
                                              ),
                                          ),
                                        ),
                                      ) 
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: CircularPercentIndicator(
                                          lineWidth: 12,
                                          radius: 50,
                                          animation: true,
                                          percent: per/100,
                                          center: Text(
                                            // "Hola",
                                            "$per %",
                                            style: TextStyle(
                                              color: clr.blanc,
                                              fontWeight: FontWeight.bold, 
                                              fontSize: 16.0
                                              ),
                                          ),
                                          circularStrokeCap: CircularStrokeCap.round,
                                          progressColor: darkmode ? clr.orange : clr.rouge,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 25, bottom: 10),
                              child: Text(
                                'Taday task :',
                                style: Theme.of(context).textTheme.bodyText1
                              ),
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: tasks!.length,
                              itemBuilder: (context, index){
                                final task = tasks[index];

                                bool check = task.done;
                                // bool check = util.getDoneTask(task);

                                return Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20) ,
                                  child: Dismissible(
                                    key: UniqueKey(),
                                    onDismissed: (diss){
                                      util.deleteTask(task);
                                    },
                                    // background: Container(color: Colors.pink,),
                                    child : Card(
                                      child: CheckboxListTile(
                                        tileColor: darkmode ? clr.bleuGris : clr.blanc,
                                        // tileColor: clr.blanc,
                                        activeColor: darkmode ? clr.bleuFonce : clr.bleuFonce,
                                        checkColor: darkmode ?clr.blanc : clr.blanc,
                                        title: Text(
                                          "${StringUtils.capitalize(task.title.toString())}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: darkmode ? clr.blanc : clr.bleuFonce,
                                            decoration: check == true ? TextDecoration.lineThrough : null,
                                          ),
                                        ) ,
                                        secondary: Container(
                                          margin: EdgeInsets.only(top: 5, bottom: 5),
                                          width: 10, 
                                          color: check == true 
                                          ? Colors.grey : 
                                          task.priority == 0 
                                          ? darkmode ? clr.blanc : clr.bleuFonce :
                                          task.priority == 1 
                                          ? clr.bleuCiel :
                                          task.priority == 2 
                                          ? clr.orange : clr.rouge ,
                                        ),
                                        controlAffinity: ListTileControlAffinity.leading,
                                        value: check, 
                                        onChanged: (bool? value) {
                                          print("CHENGED ");
                                          setState(() {
                                            // util.checkTask(task);
                                          });
                                                                        
                                                                        
                                          DBHelper.instance.getTask(task.title).then((value){
                                                                        
                                            Task t = Task(
                                              value[0]['title'].toString(),
                                              value[0]['done'] == 0 ? false : true ,
                                              value[0]['priority'],
                                              value[0]['category'].toString(),
                                              value[0]['description'].toString()
                                            );
                                      
                                            print(t.afficher());
                                      
                                            print("CHECK");
                                      
                                            // DBHelper.instance.checkTask(t);
                                            util.checkTask(t); 

                                            setState(() {
                                              
                                              check = util.getDoneTask(task);
                                            });

                                            print(" VERIFY CHECK");
                                            print(t.afficher()); 


                                                                        
                                          });
                                                                        
                                                                        
                                                                        
                                        }, 
                                          
                                      ),
                                    ),
                                  ),
                                  
                                  
                                );
                              }
                            ),
                            Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.1),)
                          ],
                        );
                      }
                    }
                    else{
                      return LoadingData(width: width, height: height);
                    }
                  },
                ),
              ),

             
            
            
            ],
          ),
        ) 
      ),
    

    );
  }

  
}




// ListTile(
//                                         title: ExpansionTile(
//                                           title: Text(
//                                             task.title,
//                                             style: Theme.of(context).textTheme.bodyText2,
//                                           ),
//                                           collapsedIconColor: darkmode ? clr.bleuFonce : clr.orange,
//                                           // leading: const Icon(Icons.info), 
                                          
//                                           trailing: _customTileExpanded 
//                                           ? Icon(
//                                               Icons.arrow_drop_up_outlined,
//                                               color: darkmode ? clr.bleuFonce : clr.orange,
//                                           )
//                                           : Icon(
//                                               Icons.arrow_drop_down,
//                                               color: darkmode ? clr.bleuFonce : clr.orange,
//                                           ),

                                        
//                                           onExpansionChanged: (bool expanded) {
//                                             setState(() => _customTileExpanded = !_customTileExpanded );
//                                           },
//                                           children: [
//                                             ListTile(
//                                               title: Text(
//                                                 "${task.description}",
//                                                 style: Theme.of(context).textTheme.bodyText2
//                                               ),
                                               
//                                             ),
//                                           ],
//                                         ),
                                        
//                                         leading: Transform.scale(
//                                           scale: 1.5,
//                                           child: Checkbox(
//                                             value: check, 
//                                             onChanged: (bool? value) {
//                                               print("CHENGED ");
//                                               setState(() {
//                                                 util.checkTask(task);
//                                               });
                                        
                                        
//                                               DBHelper.instance.getTask(task.title).then((value){
                                        
//                                               Task t = Task(
//                                                 value[0]['title'].toString(),
//                                                 value[0]['done'] == 0 ? false : true ,
//                                                 value[0]['priority'],
//                                                 value[0]['category'].toString(),
//                                                 value[0]['description'].toString()
//                                               );
                                        
//                                               print(t.afficher());
                                        
//                                               print("CHECK");
                                        
//                                               // DBHelper.instance.checkTask(t);
//                                               util.checkTask(t); 
                                        
//                                               print(" VERIFY CHECK");
//                                               print(t.afficher()); 
                                        
//                                             });
                                        
                                        
                                        
//                                             }, 
                                             
//                                           ),
//                                         ), 
//                                       ),

// Categories
              // Container( 
              //   width: width,
              //   height: height*0.2,
              //   color: Colors.lightGreen,
              //   child: FutureBuilder<List<Category>>(
              //     future: DBHelper.instance.allCategories(),
              //     builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot){
              //       if (snapshot.hasData) {
              //         List<Category>? categories = snapshot.data;
              //         return ListView.builder(
              //           // physics: const NeverScrollableScrollPhysics(),
              //           scrollDirection: Axis.horizontal,
              //           shrinkWrap: true,
              //           itemCount: categories!.length,
              //           itemBuilder: (context, index){
              //             final categ = categories[index];
              //             return Padding(
              //               padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              //               child: Container(
              //                 color: Colors.blueAccent,
              //                 width: 250,
              //                 child: Center(
              //                   child: Text(
              //                     categ.name,
              //                     style: Theme.of(context).textTheme.headline1,
              //                   ),
              //                 ),
              //               ),
              //             );
                          
              //           }
              //         );
              //       }
              //       else{
              //         return Center(
              //           child: Text(
              //             'Loading data ...',
              //             style: Theme.of(context).textTheme.headline1,
              //             )
              //         );
                      
              //       }
              //     },
              //   ),
              // ),



// //Todays tasks
//               Container( 
//                 width: width,
//                 // height: height,
//                 // color: Colors.greenAccent,
//                 child: ListView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: 5,
//                   itemBuilder: (BuildContext context, int position){
//                     return Card(
//                       color:  Colors.deepOrangeAccent,
//                       elevation: 2.0,
//                       child : ListTile(
//                         title: const ExpansionTile(
//                           title: Text('Task to do'),
//                           // lading: const Icon(Icons.info), 
//                           children: [
//                             ListTile(title: Text("Hello"),),
//                             ListTile(title: Text("world"),),
//                             ListTile(title: Text("boooh"),),
//                           ],
//                         ),
                        
//                         trailing: Icon(Icons.delete),

//                         leading: Checkbox(
//                           activeColor: Colors.amber[800],
//                           value: true, 
//                           onChanged: null
//                         ),
//                         onLongPress: null 
//                       ),
//                     );
//                   }
//                 ),
//               ),




// FutureBuilder<List<Task>> (
//                 future: DBHelper.instance.allTasks(),
//                 builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot){
//                   if (snapshot!.hasData) {
//                     List<Task>? tasks = snapshot.data;
//                     return ListView.builder(
//                       itemCount: tasks!.length,
//                       itemBuilder: (context, index){
//                         final task = tasks[index];
//                         return Card(
//                           color:  Colors.amberAccent,
//                           elevation: 2.0,
//                           child : ListTile(
//                             title: ExpansionTile(
//                               title: Text(task.title),
//                               // lading: const Icon(Icons.info), 
//                               children: const  [
//                                 ListTile(title: Text("Hello"),),
//                                 ListTile(title: Text("world"),),
//                               ],
//                             ),
                            
//                             trailing: Icon(Icons.delete),

//                             leading: Checkbox(
//                               activeColor: Colors.amber[800],
//                               value: true, 
//                               onChanged: null
//                             ),
//                             onLongPress: null 
//                           ),
//                         );
//                       }
//                     );
                    
//                   }
//                   else{
//                     return Center(
//                       child: Text(
//                         'Hawahhaaaa',
//                         style: Theme.of(context).textTheme.headline1,
//                         )
//                     );
                    
//                   }
//                 },
//               ),