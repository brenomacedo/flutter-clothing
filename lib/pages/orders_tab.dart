import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/screens/login_screen.dart';
import 'package:virtual_store/widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    if(UserModel.of(context).isLoggedIn()) {

      String uid = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(uid).collection('orders').get(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) 
            return Center(child: CircularProgressIndicator());
          
          else
            return ListView(
              children: snapshot.data.docs.map((e) => OrderTile(e.id)).toList().reversed.toList(),
            );
        },
      );

    } else {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(Icons.view_list, size: 80.0, color: Theme.of(context).primaryColor),
            SizedBox(height: 16.0),
            Text("Faça um login para acompanhar",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.0),
            RaisedButton(child: Text("Entrar", style: TextStyle(fontSize: 18.0)),
            textColor: Colors.white, color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
            })
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );
    }

  }
}