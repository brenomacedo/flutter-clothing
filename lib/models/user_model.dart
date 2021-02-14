import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

class UserModel extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance;
  User firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;
  
  void signUp({@required Map<String, dynamic> userData, @required String pass,
  @required VoidCallback onSuccess, @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
      email: userData['email'],
      password: pass
    ).then((user) async {

      firebaseUser = user.user;

      await _saveUserData(userData);

      onSuccess();

      isLoading = false;
      notifyListeners();

    }).catchError((error) {

      onFail();
      isLoading = false;
      notifyListeners();

    });
  }

  void signIn() {

  }

  void recoverPass() {

  }

  bool isLoggedIn() {
    return false;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).set(userData);
  }

}