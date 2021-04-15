import 'package:flutter/material.dart';
import 'package:lazy_chair/images.dart';


class MyChair {

  MyChair({this.images,this.bgColor, this.chairName, this.by, this.price, this.rating});

  final List<String> images;
  final int bgColor;
  final String chairName;
  final String by;
  final double price;
  final double rating;

}

final chair = <MyChair>[
  MyChair(
    bgColor: 0xFFF6F6F6,
    by: 'By Regal',
    chairName: 'Bean Bag Chair',
    price: 120,
    rating: 4.8,
    images: [MyImage.chair1]
  ),
  MyChair(
      bgColor: 0xFFF6F6F6,
      by: 'By Daud',
      chairName: 'Lazy Bean Chair',
      price: 150,
      rating: 4.9,
      images: [MyImage.chair2]
  ),


];