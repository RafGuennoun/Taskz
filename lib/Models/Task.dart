class Task{

  String title;
  bool done = false;
  int priority;
  String category;
  String? description;
  String? reminder;


  Task(this.title, this.done, this.priority, this.category, [this.description, this.reminder]);

  // Task.withID(this.id, this.title, this.category, [this.description]);


  isDone()
  {
    done = true;
  } 

  notDone()
  {
    done = false;
  }

  check(){
    done = !done;
  }

  Map<String, dynamic> toMap(){
    return{
      'title' : title,
      'done' : done == true ? 1 : 0 ,
      'priority' : priority,
      'category' : category,
      'description' : description,
      'reminder' :reminder
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) => Task(
    map['title'],
    map['done'] == 1,
    map['priority'],
    map['category'],
    map['description'],
    map['rminder']
  ); 

  String afficher() {
    String t = '''
    The task :
    Title = $title 
    Done = $done 
    Priority = $priority
    Category = $category
    Description = $description
    reminder = $reminder
    ''';
    return t;
  }

}