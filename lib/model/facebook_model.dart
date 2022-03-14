import 'package:flutter/material.dart';

//Future<Map<String, dynamic>> getUserData({
//String fields = "name,email,picture.width(200)"
//}) Static type: Future<Map<String, dynamic>> Function({String fields})

class FaceBookModel{
  late final String  name;
  late final String  email;
  late final String  id;
  late final FaceBookPhotoModel  faceBookPhotoModel;

  FaceBookModel({required this.name,required this.email,required this.id,required this.faceBookPhotoModel});
  factory FaceBookModel.fromJson(Map<String,dynamic> json)=>
      FaceBookModel(name: json['name'], email: json['email'], id: json['id'], faceBookPhotoModel: FaceBookPhotoModel.fromJson(json['picture']['data']));
}

class FaceBookPhotoModel{
  late final String  url;
  late final int  height;
  late final int  width;

  FaceBookPhotoModel({required this.url,required this.height,required this.width});

  factory FaceBookPhotoModel.fromJson(Map<String,dynamic> json)=>
    FaceBookPhotoModel(
      url: json['url'],
      height: json['height'],
      width: json['width'],
    );



}