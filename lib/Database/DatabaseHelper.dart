import 'package:Taskz/Models/Category.dart';
import 'package:Taskz/Models/Picture.dart';
import 'package:Taskz/Models/Task.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {

  DBHelper._();

  static final DBHelper instance = DBHelper._();
   
  static Database? _database;

  Future<Database> get database async{
    if (_database != null ) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }
  
  static const tableTasks = """
    CREATE TABLE IF NOT EXISTS tasks 
    (
      title TEXT PRIMARY KEY,
      done INTEGER,
      priority INTEGER,
      category TEXT,
      description TEXT,
      reminder TEXT
    );"""
  ;

  static const tableCategoris = """
    CREATE TABLE IF NOT EXISTS categories 
    (
      name TEXT PRIMARY KEY,
      desc TEXT
    );"""
  ;


  static const tablePictures = """
    CREATE TABLE IF NOT EXISTS pictures 
    (
      path TEXT PRIMARY KEY,
      taskTitle TEXT
    );"""
  ;

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await  openDatabase(
      join(await getDatabasesPath(), 'DBTaskzRafGuennoun.db'),
      version: 1,
      onCreate: (db, version) async{
        await db.execute(tableTasks);
        await db.execute(tableCategoris);
        await db.execute(tablePictures);
      }
    );
  }

  // INSERT
  void insertTask(Task task) async{
    final Database db = await database;
    await db.insert(
      'tasks', 
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  void insertCategory(Category category) async{
    final Database db = await database;
    await db.insert(
      'categories', 
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  void insertPicture(Picture picture) async{
    final Database db = await database;
    await db.insert(
      'pictures', 
      picture.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  //UPDATE
  void updateTask(Task task) async {
    final Database db = await database;
    await db.update(
      "tasks", 
      task.toMap(),
      where: "title = ?",
      whereArgs: [task.title] 
    );
  }


  void checkTask(Task task) async {
    final Database db = await database;

    if (task.done == false) {
      // set to true, true == 1
      int one = 1; 
      await db.rawUpdate("Update tasks SET done = ? WHERE title = ? ", [one.toString(),task.title.toString()]);
    } else {
      //set to false, false == 0 
      int zero = 0;
      await db.rawUpdate("Update tasks SET done = ? WHERE title = ? ", [zero.toString(),task.title.toString()]);
    }
    // await db.rawUpdate("Update tasks SET done = ? WHERE title = ? ", [0,task.title]);
  }

  void updateCategory(Category category) async {
    final Database db = await database;
    await db.update(
      "categories", 
      category.toMap(),
      where: "name = ?",
      whereArgs: [category.name] 
    );
  }

  //DELETE
  void deleteTask(Task task) async {
    final Database db = await database;
    await db.delete(
      "tasks", 
      where: "title = ?",
      whereArgs: [task.title] 
    );
  }

  void deleteCategory(Category category) async {
    final Database db = await database;
    await db.delete(
      "categories", 
      where: "name = ?",
      whereArgs: [category.name] 
    );
  }

  void deletePicture(Picture picture) async {
    final Database db = await database;
    await db.delete(
      "pictures", 
      where: "path = ?",
      whereArgs: [picture.path] 
    );
  }

  //Get task
  Future<List> getTask(String title) async {
    final Database db = await database;
    var tsk = await db.query('tasks', where: 'title = "$title"');
    return tsk;
  }

  Future<List> getCategory(String name) async {
    final Database db = await database;
    var cat = await db.query('categories', where: 'name = "$name"');
    return cat;
  }

  Future<bool> existsCategory(String name) async {
    Future<List> cat = getCategory(name);
    if (cat == null) {
      return false;
    } else {
      return true;
    }
  }


  Future<bool?> getDoneTask(Task task) async {
    getTask(task.title).then((value) => (){
      // return value[0]['done'] == 0 ? false : true ;

      bool? val;

      if (value[0]['done'] == 0) {
        val = false;
      } else {
        val = true;
      }

      return val;
    });
 
  }

  // void checkTask(Task task) async {
  //   final Database db = await database;
  //   await db.update(
  //     "tasks", 
  //     task.toMap(),
  //     where: "title = ?",
  //     whereArgs: [task.title] 
  //   );
  // }
 


  // GET ALL
  Future<List<Task>> allTasks() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    List<Task> tasks = List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
    return tasks;
  }


  Future<List<Task>> getTodaysTasks() async {
    final Database db = await database;
    // final List<Map<String, dynamic>> maps = await db.query('tasks', orderBy: 'priority DESC');
    final List<Map<String, dynamic>> maps = await db.query('tasks', where: 'category = ?', whereArgs: ['Today'], orderBy: 'priority DESC');
    List<Task> tasks = List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
    return tasks;
  }


  // getNumberAllTodaysTasks() async {
  //   final Database db = await database;
  //   // final List<Map<String, dynamic>> maps = await db.query('tasks', orderBy: 'priority DESC');
  //   int nb = 0;
  //   final List<Map<String, dynamic>> maps = await db.query('tasks', where: 'category = ?', whereArgs: ['Today']);
  //   List<Task?> tasks = List.generate(maps.length, (i) {
  //     nb++;
  //   });
  //   return nb;
  
  // }




  Future<int> countTasks() async{
    final Database db = await database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM tasks'))!;
  }

  Future<int> countTodaysTasks() async{
    final Database db = await database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM tasks WHERE category = "Today"'))!;
  }

  Future<int> countTodayDoneTasks() async{
    final Database db = await database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM tasks WHERE category = "Today" AND done = 1'))!;
  }

  Future<int?> getTodayPercentage() async {
    // return (( countTodayDonesTasks()* 100 ) / countTodaysTasks());
    countTodayDoneTasks().then((done) {
      // done*100;
      countTodaysTasks().then((still) {
        return ((done*100)/still).round();
      });
    });
    return null;
  }

  Future<int> countCategories() async{
    final Database db = await database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM categories'))!;
  }

  Future<List<Category>> allCategories() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    List<Category> categories = List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });

    // final List<Category> defaultCategories = [
    //   Category('Dev', 'blabla'),
    //   Category('Sport', 'blabla'),
    // ];

    // if (categories.isEmpty) {
    //   for(Category category in  defaultCategories )
    //   {
    //     insertCategory(category);
    //   }
    //   categories = defaultCategories;
    // }
    return categories;
  }

  
}