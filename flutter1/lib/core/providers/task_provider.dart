import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/core/models/folder_model.dart';
import 'package:flutter1/core/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  Future<void> createTask(
      String? userId, String title, String description, DateTime date, String time, bool alarm, String? folder) async {
     var tasks = FirebaseFirestore.instance.collection('tasks').doc();
     var folders = FirebaseFirestore.instance.collection('folders').doc(folder);
     var user = FirebaseFirestore.instance.collection('users').doc(userId);
    final task = TaskModel(
      taskId: tasks.id,
      userId: userId,
      title: title,
      description: description,
      date: date,
      time: time,
      alarm: alarm,
      folder: folder,
      favourite: false,
    );
    final data = task.toFirestore();
     await folders.update({"itemsNb": FieldValue.increment(1)});
     await user.update({"itemsNb": FieldValue.increment(1)});
    await tasks
        .set(data)
        .then((value) => print("Task Added"))
        .catchError((error) => print("Failed to add task: $error"));
    notifyListeners();
  }

  Stream<Iterable<TaskModel>> getTasks(String? folderId) {
    if(folderId != null)
    return FirebaseFirestore.instance.collection('tasks').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => TaskModel.fromFirestore(doc.data()))
            .toList()
            .where((task) =>
                (task.userId == FirebaseAuth.instance.currentUser?.uid) &&
                (task.folder == folderId)));
    else return FirebaseFirestore.instance.collection('tasks').snapshots().map(
            (snapshot) => snapshot.docs
            .map((doc) => TaskModel.fromFirestore(doc.data()))
            .toList()
            .where((task) =>
        (task.userId == FirebaseAuth.instance.currentUser?.uid)));
  }

  TaskModel? getTask(taskId) {
    final docRef = FirebaseFirestore.instance.collection("tasks").doc(taskId);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>?;
        return TaskModel.fromFirestore(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return null;
  }

  Future deleteTask(taskId, userId, folder) async {

    var folders = FirebaseFirestore.instance.collection('folders').doc(folder);
    var user = FirebaseFirestore.instance.collection('users').doc(userId);
    final task = FirebaseFirestore.instance.collection('tasks').doc(taskId);
    await task.delete();
    await folders.update({"itemsNb": FieldValue.increment(-1)});
    await user.update({"itemsNb": FieldValue.increment(-1)});
    notifyListeners();
  }

  Future<void> addToFavourites(taskId) async {
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
      'favourite': true
    });
    notifyListeners();
  }
  Stream<Iterable<TaskModel>> getFavourites() {
      return FirebaseFirestore.instance.collection('tasks').snapshots().map(
              (snapshot) => snapshot.docs
              .map((doc) => TaskModel.fromFirestore(doc.data()))
              .toList()
              .where((task) =>
          (task.userId == FirebaseAuth.instance.currentUser?.uid) &&
              (task.favourite == true)));
  }
}
