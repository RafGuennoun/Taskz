
class Category {

  String name;
  String desc;
  

  Category( this.name, this.desc);

  Map<String, dynamic> toMap(){
    return{
      'name' : name,
      'desc' : desc
    };
  }

  //Extract Task object from Map
  factory Category.fromMap(Map<String, dynamic> map) => Category(
    map['name'],
    map['desc']
  ); 





 

  

}