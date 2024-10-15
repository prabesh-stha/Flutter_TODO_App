import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String tid;
  String uid;
  String task;
  bool status;
  DateTime dateCreated;

  Todo({required this.tid, required this.uid, required this.task, required this.status, required this.dateCreated}); 

  factory Todo.fromFirestore(Map<String, dynamic> data, String id){
    return Todo(tid: id, uid: data['uid'], task: data['task'], status: data['status'], dateCreated: (data['dateCreated'] as Timestamp).toDate());
  }

  Map<String, dynamic> toFirestore(){
    return{
      'tid' : tid,
      'uid' : uid,
      'task' : task,
      'status' : status,
      'dateCreated': Timestamp.fromDate(dateCreated),
    };
  }
}