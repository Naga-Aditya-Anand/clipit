import 'package:firebase_auth/firebase_auth.dart';


class DataModel{
  String? data;
  DataModel({this.data});

  factory DataModel.fromMap(map){
    return DataModel(
       data: map['data'],
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'data' : data
    };
  }

}