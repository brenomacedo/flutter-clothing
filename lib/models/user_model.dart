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

  @override
  void addListener(listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }
  
  void signUp({@required Map<String, dynamic> userData, @required String pass,
  @required VoidCallback onSuccess, @required VoidCallback onFail}) async {
    isLoading = false;
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

  void signIn({@required String email, @required String pass,
  @required VoidCallback onSuccess, @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: pass)
      .then((user) async {
        firebaseUser = user.user;

        await _loadCurrentUser();

        onSuccess();
        isLoading = false;
        notifyListeners();

      }).catchError((error) {

        onFail();
        isLoading = false;
        notifyListeners();

      });
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).set(userData);
  }

  void signOut() async {
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  Future<Null> _loadCurrentUser() async {
    if(firebaseUser == null)
      firebaseUser = _auth.currentUser;
    if(firebaseUser != null) {
      if(userData['name'] == null) {
        DocumentSnapshot docUser = await FirebaseFirestore.instance.collection('users')
          .doc(firebaseUser.uid).get();
        userData = docUser.data();
      }
    }
    notifyListeners();
    
  }

}