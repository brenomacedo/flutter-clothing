import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/data/cart_product.dart';
import 'package:virtual_store/models/user_model.dart';

class CartModel extends Model {

  List<CartProduct> products = [];
  UserModel user;

  bool isLoading = false;

  static CartModel of(BuildContext context) {
    return ScopedModel.of<CartModel>(context);
  }

  CartModel(this.user);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    FirebaseFirestore.instance.collection('users').doc(user.firebaseUser.uid).collection('cart')
      .add(cartProduct.toMap()).then((doc) {
        cartProduct.cid = doc.id;
      });
    
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    FirebaseFirestore.instance.collection('users').doc(user.firebaseUser.uid)
      .collection('cart').doc(cartProduct.cid).delete();

    products.remove(cartProduct);

    notifyListeners();
  }

}