import 'package:flutter/material.dart';
import 'package:lazy_chair/config/config.dart';
import 'package:lazy_chair/screens/oders/orders.dart';

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
  Future getCoupon()async{
    GlobalData.isLoading=true;
    setState(() {

    });
    coupon = await wooCommerce.getCoupons();

    setState(() {

    });
    GlobalData.isLoading=false;
    setState(() {

    });
    print(coupon);

  }


  @override
  void initState() {
    // TODO: implement initState
    getCoupon();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalData.orange,
        centerTitle: true,

        title: Text(
          "My Coupons",
          style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * .045,
              fontWeight: FontWeight.w500),
        ),

        elevation: 0,
      ),
      body: GlobalData.isLoading==true?Center(child: Text("Loading...")):coupon.isEmpty?
      Center(child: Text("No Orders")):Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            height: MediaQuery.of(context).size.height*.02,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15,bottom: 15),
            child: Text("Available Coupons",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: coupon.length,
              itemBuilder: (c,i){
                return  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: GlobalData.black)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width:MediaQuery.of(context).size.width*0.3,
                                      decoration: BoxDecoration(
                                        color: GlobalData.orange,

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Center(child: Text(coupon[i].code)),
                                      )),
                                    Spacer(),
                                  Text("Valid till "+coupon[i].dateExpires.substring(0,10))
                                ],
                              ),
                             SizedBox(height: 5,),
                              Text("Get "+coupon[i].amount+" "+coupon[i].discountType+" off on cart items"),
                              //Text(coupon[i].minimumAmount),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,)

                    ],
                  ),
                );
              },
            ),
          )

        ],
      ),
    );
  }
}
