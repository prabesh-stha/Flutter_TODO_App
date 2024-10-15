import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_app/models/todo.dart';

class TodoService {

static final FirebaseFirestore _todoService = FirebaseFirestore.instance;

static Future<void> createNewTodo(String task, String uid)async{
 final DocumentReference doc = _todoService.collection("todos").doc();
 Todo newTodo = Todo(tid: doc.id, uid: uid, task: task, status: false, dateCreated: DateTime.now());
 await doc.set(newTodo.toFirestore());
}

static Stream<List<Todo>> fetchTodos(String uid){
  return _todoService.collection("todos").where('uid', isEqualTo: uid).snapshots().map((snapshot) => snapshot.docs.map((doc) => Todo.fromFirestore(doc.data(), doc.id)).toList());
}

static Future<void> updateTodoStatus(String tid, bool newStatus) async{
  await _todoService.collection("todos").doc(tid).update({
    'status' : newStatus,
  });
}

static Future<void> deleteTodo(String tid) async{
  await _todoService.collection("todos").doc(tid).delete();
}

}