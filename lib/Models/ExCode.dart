/*
import 'dart:convert';
import 'package:Taskz/Database/Database.dart';
import 'package:Taskz/UI/Colors.dart';
import 'package:Taskz/Widgets/TaskGetter.dart';
import 'package:Taskz/Widgets/WelcomeText.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Task.dart';


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

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Task> tasksList = [];
  int count = 0;

  Task task1 = Task('Hello', false, 'today');
  Task task2 = Task('World', false, 'today');
  Task task3 = Task('Mommy', false, 'today');
 
  
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

    var clr = PersonalColors();
    
    // if (tasksList == null ) {
    //   List<Task> newList = [];
    //   tasksList = newList;
    // }

    tasksList.add(task1);
    tasksList.add(task2);
    tasksList.add(task3);





    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    void _showSnackBar(BuildContext context, String msg){
      final snackBar = SnackBar(content: Text(msg));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Future<void> _delete(BuildContext context, Task task) async {
      int? result = await databaseHelper.deleteTask(task.id!);
      if (result != 0 ) {
        _showSnackBar(context, 'Task deleted succesfully');
      }
    
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
                secondary: const Icon(Icons.nightlight_round),
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
                  
                  child: TaskGetter() 
                ),
              ) 
          );
        }
      ),
      
      body: SafeArea(
        child: Container(
          width: width,
          // height: height,
          // color: Colors.orangeAccent,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [

              // Welcome text
              WelcomeText(width, height, username!, context),

              // Categories
              Container( 
                width: width,
                height: height*0.3,
                color: Colors.lightGreen,
                child: Center(
                  child: TextButton(
                    child: Text('Show data'),
                    onPressed: (){

                    }, 
                  ),
                ),
              ),

              //Todays tasks
              Container( 
                width: width,
                // height: height,
                // color: Colors.greenAccent,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int position){
                    return Card(
                      color:  Colors.deepOrangeAccent,
                      elevation: 2.0,
                      child : ListTile(
                        title: const ExpansionTile(
                          title: Text('Task to do'),
                          // lading: const Icon(Icons.info), 
                          children: [
                            ListTile(title: Text("Hello"),),
                            ListTile(title: Text("world"),),
                            ListTile(title: Text("boooh"),),
                          ],
                        ),
                        
                        trailing: Icon(Icons.delete),

                        leading: Checkbox(
                          activeColor: Colors.amber[800],
                          value: true, 
                          onChanged: null
                        ),
                        onLongPress: null 
                      ),
                    );
                  }
                ),
              ),
            
            
            ],
          ),
        ) 
      ),
    

    );
  }

  
}
  // physics: const NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,


*/






/*

import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../Models/Task.dart';


class DatabaseHelper {

  static DatabaseHelper? _databaseHelper;  //singleton 
  static Database? _database;

  DatabaseHelper._createInstance();

  // Task
  String taskTable = 'task_table';
  String colIdTask = 'id';
  String colTitle = 'title';
  String colDone = 'done';
  String colDescription = 'description';
  String colCategory = 'category';

  //Category
  String cetegoryTable = 'category_table';
  String colIdCat = 'id';
  String colName = 'name';
  String colDesc = 'desc';
  
  factory DatabaseHelper(){
    // if (_databaseHelper == null) {
    //   _databaseHelper = DatabaseHelper._createInstance();
    // }
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> initializeDB() async {
    // Get the directory path for both Android and IOS
    Directory directory = await getApplicationDocumentsDirectory();
    String path =  directory.path + 'tasks.db';

    // Open/Create the DB at a given path
    var tasksDB = openDatabase(path, version: 1, onCreate: _createDB);

    return tasksDB;


  }

  void _createDB(Database db, int newVersion ) async{

    String createTaskTable = '''
      CREATE TABLE $taskTable (
        $colIdTask INTEGER PRIMARY KEY AUTOINCREMENT,
        $colTitle TEXT,
        $colDone INTEGER,
        $colCategory TEXT,
        $colDescription TEXT
      )
    ''';

    String createCategoryTable = '''
      CREATE TABLE $taskTable (
        $colIdCat INTEGER PRIMARY KEY AUTOINCREMENT,
        $colName TEXT,
        $colDesc TEXT
      )
    ''';

    await db.execute(createTaskTable);
    await db.execute(createCategoryTable);
  }


  // Fetsh : get all tasks from db
  Future<List<Map<String, dynamic>>?> getTaskMapList() async {
    Database? db = _database;
    var result = await db?.query(taskTable);
    return result;
  }

  // Insert 
  Future<int?> insetTask(Task task) async{
    Database? db = _database;
    var result = await db?.insert(taskTable,   task.toMap());
    return result;
  }

  // Update 
  Future<int?> updateTask(Task task) async{
    Database? db = _database;
    var result = await db?.update(taskTable, task.toMap(), where: '$colIdTask = ?', whereArgs: [task.id]);
    return result;
  }

  // Delete 
  Future<int?> deleteTask(int id) async{
    Database? db = _database;
    var result = await db?.rawDelete('DELETE FROM $taskTable WHERE $colIdTask = $id');
    return result;
  }

   // NB tasks 
  Future<int?> countTask() async{
    Database? db = _database;
    List<Map<String, dynamic>> x = await db!.rawQuery('SELECT COUNT(*) FROM $taskTable');
    int? result = Sqflite.firstIntValue(x); 
    return result;
  }

  // https://www.youtube.com/watch?v=xke5_yGL0uk&list=PLDQl6gZtjvFu5l20K5KTEBLCjfRjHowLj&index=8

}

 */


// 


// ListView.builder(
//                               physics: const NeverScrollableScrollPhysics(),
//                               shrinkWrap: true,
//                               itemCount: tasks!.length,
//                               itemBuilder: (context, index){
//                                 final task = tasks[index];
//                                 return Padding(
//                                   padding: const EdgeInsets.only(left: 10, right: 10),
//                                   child: Card(
//                                     child : ListTile(
//                                       title: ExpansionTile(
//                                         title: Text(
//                                           task.title,
//                                           style: Theme.of(context).textTheme.bodyText2,
//                                         ),
//                                         collapsedIconColor: darkmode ? clr.bleuFonce : clr.orange,
//                                         // leading: const Icon(Icons.info), 
                                        
//                                         trailing: _customTileExpanded 
//                                         ? Icon(
//                                             Icons.arrow_drop_up_outlined,
//                                             color: darkmode ? clr.bleuFonce : clr.orange,
//                                         )
//                                         : Icon(
//                                             Icons.arrow_drop_down,
//                                             color: darkmode ? clr.bleuFonce : clr.orange,
//                                         ),

                                       
//                                         onExpansionChanged: (bool expanded) {
//                                           setState(() => _customTileExpanded = !_customTileExpanded );
//                                         },
//                                         children: [
//                                           ListTile(title: Text("Done : ${task.done.toString()}")),
//                                           ListTile(title: Text("Category : ${task.category}"),),
//                                           ListTile(title: Text("Description : \n${task.description}",),),
//                                         ],
//                                       ),
                                      
//                                       leading: Checkbox(
//                                         value: false, 
//                                         onChanged: null
//                                       ),
//                                       onLongPress: null 
//                                     ),
//                                   ),
//                                 );
//                               }
//                             ),