import 'package:flutter/material.dart';
import 'package:virtual_store/pages/home_tab.dart';
import 'package:virtual_store/pages/orders_tab.dart';
import 'package:virtual_store/pages/products_tab.dart';
import 'package:virtual_store/widgets/cart_button.dart';
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
          floatingActionButton: CartButton(),
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
        Scaffold(
          appBar: AppBar(
            title: Text("Meus pedidos"),
            centerTitle: true
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        ),
      ],
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
    );
  }
}