import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/data/cart_product.dart';
import 'package:virtual_store/data/product_data.dart';
import 'package:virtual_store/models/cart_model.dart';

class CartTile extends StatelessWidget {

  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {

    Widget _buildContent() {

      CartModel.of(context).updatePrices();

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            width: 120.0,
            child: Image.network(cartProduct.productData.images[0], fit: BoxFit.cover)
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cartProduct.productData.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                  Text("Tamanho: ${cartProduct.size}", style: TextStyle(fontWeight: FontWeight.w300)),
                  Text("R\$ ${cartProduct.productData.price.toStringAsFixed(2)}",
                    style: TextStyle(fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Theme.of(context).primaryColor),
                        onPressed: cartProduct.quantity > 1 ? () {
                          CartModel.of(context).decProduct(cartProduct);
                        } : null
                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
                        onPressed: () {
                          CartModel.of(context).incProduct(cartProduct);
                        }
                      ),
                      FlatButton(
                        child: Text("Remove"),
                        onPressed: () {
                          CartModel.of(context).removeCartItem(cartProduct);
                        },
                        textColor: Colors.grey,
                      )
                    ],
                  )
                ],
              ),
            )
          )
        ]
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: cartProduct.productData == null ?
        FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('products')
            .doc(cartProduct.category).collection('items').doc(cartProduct.pid).get(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              cartProduct.productData = ProductData.fromDocument(snapshot.data);
              return _buildContent();
            } else {
              return Container(
                height: 70.0,
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              );
            }
          },
        ) : _buildContent(),
    );
  }
}