import 'package:flutter/material.dart';
import 'package:lazy_chair/config/config.dart';

import '../../woocommerce.dart';
import '../global.dart';

class Coupon extends StatefulWidget {
  @override
  _CouponState createState() => _CouponState();
}

class _CouponState extends State<Coupon> {

  WooCommerce wooCommerce = WooCommerce(
    baseUrl: Config.baseUrl,
    consumerKey: Config.key,
    consumerSecret: Config.secret,
    isDebug: true,
  );
  List<WooCoupon> coupon = [];
  getCoupon()async{
    GlobalData.isLoading=true;
    setState(() {

    });
    coupon = await wooCommerce.getCoupons();

    setState(() {

    });
    GlobalData.isLoading=false;
    setState(() {

    });
    print(coupon.toString());

  }


  @override
  void initState() {
    // TODO: implement initState
    getCoupon();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
