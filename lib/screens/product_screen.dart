import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:virtual_store/data/cart_product.dart';
import 'package:virtual_store/data/product_data.dart';
import 'package:virtual_store/models/cart_model.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/screens/cart_screen.dart';
import 'package:virtual_store/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {

  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductData product;

  String selectedSize;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((img) {
                return NetworkImage(img);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: Theme.of(context).primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(product.title, style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500
                ),
                maxLines: 3),
                Text("R\$ ${product.price.toStringAsFixed(2)}", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor
                )),
                SizedBox(
                  height: 16.0
                ),
                Text("Tamanho", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5
                    ),
                    scrollDirection: Axis.horizontal,
                    children: product.sizes.map((size) {
                      return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(color: size == selectedSize ?
                              Colors.blue : Colors.grey[500], width: 3.0)
                          ),
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(size),
                        ),
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                      );
                    }).toList(),
                  )
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    child: Text(UserModel.of(context).isLoggedIn() ?'Adicionar ao carrinho' :
                    "Entre para comprar", style: TextStyle(fontSize: 18.0)),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: selectedSize == null ? null : () {

                      if(UserModel.of(context).isLoggedIn()) {

                        CartProduct cartProduct = CartProduct();
                        cartProduct.size = selectedSize;
                        cartProduct.quantity = 1;
                        cartProduct.pid = product.id;
                        cartProduct.category = product.category;
                        cartProduct.productData = product;

                        
                        CartModel.of(context).addCartItem(cartProduct);

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CartScreen()
                        ));

                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()
                        ));
                      }
                    },
                  )
                ),
                SizedBox(height: 16.0),
                Text("Descrição", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                Text(product.description, style: TextStyle(fontSize: 16.0))
              ],
            )
          )
        ]
      )
    );
  }
}