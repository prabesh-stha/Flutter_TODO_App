import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';

class User {
  User({required this.uid, required this.email, required this.name});

  String uid;
  String email;
  String name;

  factory User.fromFirestore(DocumentSnapshot doc){
    Map data = doc.data() as Map<String, dynamic>;
    return User(
      uid: data['uid'],
      email: data['email'],
      name: data['name']
    );
  }

  Map<String, dynamic> toFirestore(){
    return {
      'uid': uid,
      'email': email,
      'name' : name
    };
  }

}