class User1 {
  String userid;
  String name;
  String birth;
  int age;

  User1({required this.userid, required this.name, required this.birth, required this.age});

  factory User1.fromJson(Map<String, dynamic> jsonData){
    return User1(
        userid: jsonData['userid'],
        name: jsonData['name'],
        birth: jsonData['birth'],
        age: jsonData['age']
    );

  }
  Map<String, dynamic> toJson(){
    return {
      "userid": userid,
      "name": name,
      "birth": birth,
      "age": age,
    };
  }
}
