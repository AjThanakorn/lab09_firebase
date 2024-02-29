import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
class FireBaseController extends GetxController{
  //CRUD operation
  final CollectionReference todos=FirebaseFirestore.instance.collection('todos');
  Future<void> addToDo(String todo){
    return todos.add({
      'title': todo,
      'time':Timestamp.now()  }
    );
  }
//read
Stream<QuerySnapshot> GetToDoList(){
    final todo_snapshot=todos.orderBy('time',descending: true).snapshots();
  return todo_snapshot;
}
//update
Future<void> updateToDo(String docID,String editTodoText){
    return todos.doc(docID).update({
      'title':editTodoText,
      'time':Timestamp.now()
    });
}
//delete
}