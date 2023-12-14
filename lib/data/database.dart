import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_application/models/task_model.dart';

class Database {
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  /// So First Let create a function for a add a Todo to a current a user list..
  Future<void> addTodo({
    required String title,
  }) async {
    try {
      EasyLoading.show();
      String taskId = DateTime.now().microsecondsSinceEpoch.toString();
      Task allTask = Task(id: taskId, title: title, isCompleted: false);
     await firestore.collection("todos").doc(_auth.currentUser!.uid).collection("My-todos").doc(taskId).set(
          allTask.toJson());
      EasyLoading.dismiss();
      EasyLoading.showSuccess(
        "Todo Added",
      );
    }
    catch(e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }
}
