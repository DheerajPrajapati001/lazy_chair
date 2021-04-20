import 'package:flutter/material.dart';

class CartProducts {
  String productId;
  String quantity;

  CartProducts({this.productId, this.quantity});

  CartProducts.fromJson(Map<String, dynamic> json) {
    productId = int.parse(json['id'].toString()).toString();
    quantity = int.parse(json['quantity'].toString()).toString();
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}


/*
List<CartProducts> myProducts = [CartProducts()];

jsonEncode(myProducts);*/
