import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  String? uid;
  String? name;
  String? email;

  UserModel({this.uid,this.name,this.email});

  //get data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email']
    );
  }

  //sending data to server
  Map<String, dynamic> toMap(){
    return{
      'uid' : uid,
      'name' : name,
      'email' : email,
    };
  }
}