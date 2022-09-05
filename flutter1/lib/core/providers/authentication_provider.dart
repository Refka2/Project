import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/core/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class AuthenticationProvider extends ChangeNotifier {
  var downloadUrl;
  var _basename;

  String _error = "";
  String get error => _error;
  setError(String error){
    _error = error;
  }
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addUser(String? userId, String username, String email, String age, String? uid) async {
    DocumentReference<Map<String, dynamic>> users = FirebaseFirestore.instance
        .collection('users')
        .doc(uid);
    final user = UserModel(
      userId: userId,
      username: username,
      email: email,
      age: age,
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/todoapp-2e3f4.appspot.com/o/images%2Favatar_girl.webp?alt=media&token=9286488a-8c55-4aac-937b-042d986ea09c',
      itemsNb: 0
    );
    final data = user.toFirestore();
      await users.set(data)
    .then((value) => print("user Added"))
    .catchError((value) => print(value));
  }

  Future<void> signUp(email, password, username, age) async {
    setError("");
    try {
      UserCredential? userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String? userId = userCredential.user?.uid;
      addUser(userId, username, email, age, userId);
    } on FirebaseAuthException catch (e) {
      setError(e.code) ;
    }
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    setError("");
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      setError(e.code) ;
      print(e.code);
    }
    notifyListeners();
  }

  void logOut() async {
    await auth.signOut();
    notifyListeners();
  }
  // UserModel? getUser() {
  //   final docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid);
  //   docRef.get().then(
  //         (DocumentSnapshot doc) {
  //       final data = doc.data() as Map<String, dynamic>;
  //       return UserModel
  //           .fromFirestore(data);
  //     },
  //     onError: (e) => print("Error getting document: $e"),
  //   );
  //   return null;
  // }
  Stream<Iterable<UserModel>> getUser() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>snapshot.docs.map((doc) => UserModel.fromFirestore(doc.data())).toList().where((task) => task.userId == FirebaseAuth.instance.currentUser?.uid));

  Future<void> updateUserData(
      String? username, String? email, String? age, String? imageUrl, String? uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'username': username,
      'email': email,
      'age': age,
      'imageUrl': imageUrl,
    });
    notifyListeners();

  }

  Future<void> uploadImage() async {
    final _storage = FirebaseStorage.instance;
      //Select Image
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image != null) {
        //Upload to Firebase
        File file = new File(image.path);
        _basename = basename(file.path);
        var snapshot =
        await _storage.ref().child('images/$_basename').putFile(file);

        downloadUrl = await snapshot.ref.getDownloadURL();
        print(downloadUrl);
        notifyListeners();
      } else {
        print('No Path Received');
      }
  }

  String get url => downloadUrl;

  String get fileName => _basename;

  Future<void> resetPassword({required String email}) async {
    setError("") ;
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .catchError((e) => setError(e.code) );
    notifyListeners();
  }


}
