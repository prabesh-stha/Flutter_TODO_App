import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_app/models/user.dart';

class UserService{
  static final _userService = FirebaseFirestore.instance;

  static Future<void> createUser(User user) async{
    final DocumentReference doc = _userService.collection("users").doc(user.uid);
    await doc.set({
      "uid": user.uid,
      "email": user.email,
      "name": user.name
    });
  }
}