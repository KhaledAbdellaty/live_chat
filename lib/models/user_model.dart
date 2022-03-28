
class UserModel{
  String? id;
  String? name;
  String? email;
  String? password;
  String? avatar;

  UserModel({this.id, this.name, this.email, this.password, this.avatar});
  Map<String,dynamic> toMap(){
    final map = <String,dynamic>{
      'name' : name,
      'uid' : id,
      'email' : email,
      'password' : password,
      'pic' : avatar
    };
    return map;
  }
  factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel(
        id: map['uid'],
        name:  map['name'],
        password: map['password'],
        email: map['email'],
        avatar: map['pic']
    );
  }
}