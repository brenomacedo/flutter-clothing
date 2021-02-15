import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/data/cart_product.dart';
import 'package:virtual_store/models/user_model.dart';

class CartModel extends Model {

  List<CartProduct> products = [];
  UserModel user;

  String couponCode;
  int discountPercentage = 0;

  bool isLoading = false;

  static CartModel of(BuildContext context) {
    return ScopedModel.of<CartModel>(context);
  }

  CartModel(this.user) {
    if(user.isLoggedIn())
      _loadCartItems();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;

    FirebaseFirestore.instance.collection('users').doc(user.firebaseUser.uid).collection('cart')
      .doc(cartProduct.cid).update(cartProduct.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;

    FirebaseFirestore.instance.collection('users').doc(user.firebaseUser.uid).collection('cart')
      .doc(cartProduct.cid).update(cartProduct.toMap());
    notifyListeners();
  }

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

  void _loadCartItems() async {
    QuerySnapshot query = await FirebaseFirestore.instance.collection('users')
      .doc(user.firebaseUser.uid).collection('cart').get();

    products = query.docs.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage  = discountPercentage;
  }

  double getProductsPrice() {
    double price = 0.0;
    for(CartProduct c in products) {
      if(c.productData != null)
        price += c.quantity * c.productData.price;
    }

    return price;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

  double getShipPrice() {
    return 9.99;
  }

  void updatePrices() {
    notifyListeners();
  }

  Future<String> finishOrder() async {
    if(products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();



    DocumentReference refOrder = await FirebaseFirestore.instance.collection('orders').add({
      'clientId': user.firebaseUser.uid,
      'products': products.map((e) => e.toMap()).toList(),
      'shipPrice': shipPrice,
      'procuctsPrice': productsPrice,
      'discount': discount,
      'totalPrice': shipPrice + productsPrice - discount,
      'status': 1
    });

    await FirebaseFirestore.instance.collection('users').doc(user.firebaseUser.uid)
      .collection('orders').doc(refOrder.id).set({
        "orderId": refOrder.id
      });

    QuerySnapshot query = await FirebaseFirestore.instance.collection('users').doc(user.firebaseUser.uid)
      .collection('cart').get();

    for(DocumentSnapshot doc in query.docs) {
      doc.reference.delete();
    }

    products.clear();
    discountPercentage = 0;
    couponCode = null;
    isLoading = false;
    notifyListeners();

    return refOrder.id;

  }

}