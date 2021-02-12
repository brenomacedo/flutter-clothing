import 'package:flutter/material.dart';
import 'package:virtual_store/pages/home_tab.dart';
import 'package:virtual_store/pages/products_tab.dart';
import 'package:virtual_store/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
        ),
        Container(color: Colors.green,),
        Container(color: Colors.blue,),
      ],
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
    );
  }
}