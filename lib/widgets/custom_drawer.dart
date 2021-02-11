import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 203, 236, 241),
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
    );

    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170,
                child: Stack(
                  children: [
                    Positioned(
                      top: 8.0,
                      left: 0,
                      child: Text("Flutter's \n Clothing",
                      style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold))
                    )
                  ],
                ),
              )
            ],
          )
        ]
      )
    );
  }
}