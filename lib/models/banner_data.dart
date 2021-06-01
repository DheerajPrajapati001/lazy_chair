import 'package:flutter/material.dart';

class BannerData {
  String id;
  String pic;

  BannerData({this.id, this.pic});

  BannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pic'] = this.pic;
    return data;
  }
}