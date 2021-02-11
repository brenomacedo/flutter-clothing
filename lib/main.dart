import 'package:flutter/material.dart';
import 'package:virtual_store/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: "Flutter's Clothing",
    theme: ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Color.fromARGB(255, 4, 125, 141)
    ),
    debugShowCheckedModeBanner: false,
    home: HomeScreen()
  ));
}