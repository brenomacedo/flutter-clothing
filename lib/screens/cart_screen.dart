import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/models/cart_model.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/screens/login_screen.dart';
import 'package:virtual_store/widgets/cart_tile.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu carrinho"),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {

                int p = model.products.length;

                return Text("${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}", style: TextStyle(fontSize: 17.0));
              },
            )
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if(model.isLoading && UserModel.of(context).isLoggedIn())
            return Center(child: CircularProgressIndicator());
          
          if(!UserModel.of(context).isLoggedIn())
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(Icons.remove_shopping_cart, size: 80.0, color: Theme.of(context).primaryColor),
                  SizedBox(height: 16.0),
                  Text("Faça um login para adicionar produtos",
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
          
          if(model.products == null || model.products.length == 10)
            return Center(child: Text("Nenhum produto no carrinho", style: TextStyle(fontSize: 20,
            fontWeight: FontWeight.bold), textAlign: TextAlign.center));

          return ListView(
            children: [
              Column(
                children: model.products.map((item) {
                  return CartTile(item);
                }).toList()
              )
            ],
          );

        },
      ),
    );
  }
}