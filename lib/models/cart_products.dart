import 'package:flutter/material.dart';

class CartProducts {
  String productId;
  String quantity;
  String name;
  //String total;

  CartProducts({this.productId, this.quantity,this.name});

  CartProducts.fromJson(Map<String, dynamic> json) {
    productId = int.parse(json['id'].toString()).toString();
    quantity = int.parse(json['quantity'].toString()).toString();
    name = json['name'].toString();
    //total = json['total'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    //data['total'] = this.total;
    return data;
  }
}


/*
List<CartProducts> myProducts = [CartProducts()];

jsonEncode(myProducts);*/
