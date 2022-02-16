class Picture {
  
  String path;
  bool taskTitle;

  Picture(this.path, this.taskTitle);

  Map<String, dynamic> toMap(){
    return{
      'path' : path,
      'taskTitle' : taskTitle
    };
  }

    //Extract Task object from Map
  factory Picture.fromMap(Map<String, dynamic> map) => Picture(
    map['path'],
    map['taskTitle']
  ); 

}