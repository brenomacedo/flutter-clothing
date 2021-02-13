import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/data/product_data.dart';

class ProductScreen extends StatefulWidget {

  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductData product;

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
                ))
              ],
            )
          )
        ]
      )
    );
  }
}