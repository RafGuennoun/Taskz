import 'package:Taskz/Database/DatabaseHelper.dart';
import 'package:Taskz/Models/Category.dart';
import 'package:Taskz/Models/Task.dart';
import 'package:flutter/material.dart';

class Utils extends ChangeNotifier {

  Utils();

  late Future<List<Task>> tasksList;
  late Future<List<Category>> CategoriesList;

  //Get all
  Future<List<Task>> getAllTasks(){
    tasksList = DBHelper.instance.allTasks();
    notifyListeners();
    return tasksList;
  }

  Future<List<Task>> getTodaysTasks(){
    tasksList = DBHelper.instance.getTodaysTasks();
    notifyListeners();
    return tasksList;
  }

  Future<List<Category>> getAllCategories(){
    CategoriesList = DBHelper.instance.allCategories();
    notifyListeners();
    return CategoriesList;
  }

  countTasks(){
    Future<int?> nb = DBHelper.instance.countTasks();
    notifyListeners();
    return nb;
  }

  countTodaysTasks(){
    Future<int?> nb = DBHelper.instance.countTodaysTasks();
    notifyListeners();
    return nb;
  }

  countTodayDoneTasks(){
    Future<int?> nb = DBHelper.instance.countTodayDoneTasks();
    notifyListeners();
    return nb;

  }
  
  getTodayPercentage(){
    DBHelper.instance.getTodayPercentage().then((value) {
      return value;
    });
 
  }

  Future<int?> countCategories(){
    Future<int?> nb = DBHelper.instance.countCategories();
    notifyListeners();
    return nb;
  }

  //Get done task
  getDoneTask(Task task) {
    Future<bool?> done = DBHelper.instance.getDoneTask(task);
    notifyListeners();
    return done;
  }

  //Check Task
  checkTask(Task task){ 
    DBHelper.instance.checkTask(task);
    notifyListeners();
  }

   




  //Adding
  addTask(Task task){
    DBHelper.instance.insertTask(task);
    notifyListeners();
  }

  addCategory(Category category){
    DBHelper.instance.insertCategory(category);
    notifyListeners();
  }

  //Deleting
  deleteTask(Task task){
    DBHelper.instance.deleteTask(task);
    notifyListeners();
  }

  deleteCategory(Category category){
    DBHelper.instance.deleteCategory(category);
    notifyListeners();
  }

  //Updateing
  updateTask(Task task){
    DBHelper.instance.updateTask(task);
    
    notifyListeners();
  }

  updateCategory(Category category){
    DBHelper.instance.updateCategory(category);
    notifyListeners();
  }

  // Get category
  //  getCategory(Category category){
  //   var cat = DBHelper.instance.getCategory(category.name);
  //   notifyListeners();
  //   return cat;
  // }


}