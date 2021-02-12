import 'package:flutter/material.dart';
import 'package:virtual_store/widgets/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {

  final PageController _pageController;
  CustomDrawer(this._pageController);

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
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: Column(
                        children: [
                          Text("Olá,", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                          GestureDetector(
                            child: Text("Entre ou Cadastre-se >", style: TextStyle(fontSize: 16.0,
                              fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                            onTap: () {}
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", _pageController, 0),
              DrawerTile(Icons.list, "Produtos", _pageController, 1),
              DrawerTile(Icons.location_on, "Encontre uma loja", _pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Meus pedidos", _pageController, 3)
            ],
          )
        ]
      )
    );
  }
}