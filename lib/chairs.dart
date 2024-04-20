import 'package:flutter/material.dart';
import 'package:lazy_chair/images.dart';


class MyChair {

  MyChair({required this.images,required this.bgColor, required this.chairName, required this.by, required this.price, required this.rating});

  final List<String> images;
  final int bgColor;
  final String chairName;
  final String by;
  final double price;
  final double rating;

}

final chair = <MyChair>[
  MyChair(
    bgColor: 0xFFDBF3FA,
    by: 'By Regal',
    chairName: 'Bean Bag Chair',
    price: 120,
    rating: 4.8,
    images: [MyImage.chair1]
  ),
  MyChair(
      bgColor: 0xFFFFE6EE,
      by: 'By Daud',
      chairName: 'Lazy Bean Chair',
      price: 150,
      rating: 4.9,
      images: [MyImage.chair2]
  ),


];