import 'package:flutter/material.dart';
import 'package:virtual_store/data/product_data.dart';
import 'package:virtual_store/screens/product_screen.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductScreen(product)
        ));
      },
      child: Card(
        child: type == "grid" ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Image.network(product.images[0], fit: BoxFit.cover),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(product.title, style: TextStyle(fontWeight: FontWeight.w500)),
                      Text("R\$ ${product.price.toStringAsFixed(2)}", style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0
                      )),
                    ]
                  ),
                )
              )
            ],
          ) :
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Image.network(product.images[0], fit: BoxFit.cover, height: 250)
              ),
              Flexible(
                flex: 1,
                child: Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(product.title, style: TextStyle(fontWeight: FontWeight.w500)),
                        Text("R\$ ${product.price.toStringAsFixed(2)}", style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0
                        )),
                      ]
                    ),
                  )
                ),
              )
            ],
          )
      ),
    );
  }
}