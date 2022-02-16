import 'package:Taskz/Database/DatabaseHelper.dart';
import 'package:Taskz/Models/Category.dart';
import 'package:Taskz/Models/Task.dart';
import 'package:Taskz/Models/Utils.dart';
import 'package:Taskz/UI/Colors.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TaskGetter extends StatefulWidget {
  // const TaskGetter({ Key? key }) : super(key: key);
  final Category category;
  TaskGetter({required this.category});

  @override
  _TaskGetterState createState() => _TaskGetterState();
}

class _TaskGetterState extends State<TaskGetter> {
  final _taskController = TextEditingController();

  bool? empty;

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
  var clr = PersonalColors();


    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _taskController.dispose();  
  }

 
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {


    return Container(
      color:Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "New task !",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),

          const SizedBox(height: 30,),

          TextField(
            controller: _taskController,

            // to write directly instead of clicking on the text field
            // autofocus: true,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                // borderSide: const BorderSide(color: Colors.grey),
              ),
              labelText: "Task",
              hintText: "What are you going to do ?",
              // errorText: empty == true ? 'Please write a task' : null
            ),

            onChanged: (newText){
              setState(() {
                empty = false;
              });
            },
          ),


          SizedBox(height: 20,),

          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Text(
                "Priority of your task",
                style: Theme.of(context).textTheme.bodyText1,
              ),

              SizedBox(height: 10,),

              Slider(
                inactiveColor: darkmode ? clr.bleuGris : Colors.grey[300],
                activeColor: darkmode 
                ? _currentSliderValue.round() == 33 
                ? clr.bleuCiel : _currentSliderValue.round() == 67 
                ? clr.orange : clr.rouge 
                : _currentSliderValue.round() == 0 
                ? clr.bleuFonce : _currentSliderValue.round() == 33 
                ? clr.bleuCiel : _currentSliderValue.round() == 67 
                ? clr.orange : clr.rouge,

                thumbColor: darkmode 
                ? _currentSliderValue.round() == 0 
                ? clr.blanc : _currentSliderValue.round() == 33 
                ? clr.bleuCiel : _currentSliderValue.round() == 67 
                ? clr.orange : clr.rouge 
                : _currentSliderValue.round() == 0 
                ? clr.bleuFonce : _currentSliderValue.round() == 33 
                ? clr.bleuCiel : _currentSliderValue.round() == 67 
                ? clr.orange : clr.rouge,
                value: _currentSliderValue,
                max: 100,
                divisions: 3,
                label: _currentSliderValue.round() == 0 
                ? "Normal" : _currentSliderValue.round() == 33 
                ? "Low" : _currentSliderValue.round() == 67 
                ? "Medium" : "High",

                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
              
            ],
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
              child: const Text("Add task"),
              onPressed: () async {

                // print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx');
                if (_taskController.text.isEmpty) {
                  print('Empty task');
                  setState(() {
                    empty = true;
                  });
                } else {

                  int p = 0;
                  switch (_currentSliderValue.round()) {
                    case 0 :
                      p=0;
                      break;

                    case 33 :
                      p=1;
                      break;

                    case 67 :
                      p=2;
                      break;

                    default: p=100;
                  }


                  Task task = Task(
                    _taskController.text,
                    false,
                    p,
                    widget.category.name,
                    '',
                    ''
                  );

                  print(task.afficher());
                  

                  Utils util = Utils();
                  // util.addTask(task);
                  

                
                  setState(() {
                    empty = false;
                  });

                  //  Provider.of<TaskData>(context, listen: false).addTask(newTaskTitle!);
                  Provider.of<Utils>(context, listen: false).addTask(task);
                  Navigator.pop(context);

                 
                }


              }, 
            ),
          ),
        ],
      ),
    );
  }
}

