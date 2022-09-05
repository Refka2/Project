import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/core/models/folder_model.dart';

class FolderProvider extends ChangeNotifier {

  Future<void> createFolder(String folderName, int itemsNb) async {
    var folders = FirebaseFirestore.instance.collection('folders').doc();
    final folder = FolderModel(
      folderId: folders.id,
      userId: FirebaseAuth.instance.currentUser?.uid,
      folderName: folderName,
      itemsNb: itemsNb,
    );
    final data = folder.toFirestore();
    await folders
        .set(data)
        .then((value) => print("Folder Added"))
        .catchError((error) => print("Failed to add folder: $error"));
    notifyListeners();
  }

  Stream<Iterable<FolderModel>> getFolder() => FirebaseFirestore.instance
      .collection('folders')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => FolderModel.fromFirestore(doc.data()))
          .toList()
          .where((folder) =>
              folder.userId == FirebaseAuth.instance.currentUser?.uid));

  Future deleteFolder(taskId) async {
    final task = FirebaseFirestore.instance.collection('folders').doc(taskId);
    await task.delete();
  }
}
