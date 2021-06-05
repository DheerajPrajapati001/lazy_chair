import 'package:flutter/material.dart';
import 'package:lazy_chair/config/config.dart';
import 'package:lazy_chair/localization/language_constants.dart';

import '../../woocommerce.dart';
import '../global.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {

  WooCommerce wooCommerce = WooCommerce(
    baseUrl: Config.baseUrl,
    consumerKey: Config.key,
    consumerSecret: Config.secret,
    isDebug: true,
  );
  WooOrder orders;
  getOrderDetails()async{

    orders = await wooCommerce.getOrderById(GlobalData.orderId);

    setState(() {

    });
    print(orders.toString());


  }

  deleteOrder()async{
    GlobalData.isLoading=true;
    setState(() {

    });
    orders = await wooCommerce.deleteOrder(orderId: GlobalData.orderId);

    setState(() {

    });
    GlobalData.isLoading=false;
    setState(() {

    });
    print(orders.toString());

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("........................$orders");
    getOrderDetails();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text(getTranslated(context, "order_details"),style: TextStyle(
             color: Colors.black,
             fontSize: MediaQuery.of(context).size.width * .045,
             fontWeight: FontWeight.w500)),
         centerTitle: true,
         backgroundColor: GlobalData.orange,

       ),

      body: orders==null?Center(child: Text("Loading...")):SingleChildScrollView(
        physics: ScrollPhysics(),

        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Expanded(
                            child: Text(getTranslated(context, "order_summary"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                          ),
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.orange.shade200,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(child: Text(orders.status)),
                                ))
                          )
                        ],
                      ),

                      SizedBox(height: 20,),
                      CustomTextInRow(
                        mainText: getTranslated(context, "order_id"),
                        price: "#"+orders.id.toString(),

                      ),

                      CustomTextInRow(
                        mainText: getTranslated(context, "order_created"),
                        price: orders.dateCreated.substring(0,10),

                      ),

                      CustomTextInRow(
                        mainText: getTranslated(context, "subtotal"),
                        price: orders.currency+" "+((double.parse(orders.total))-(double.parse(orders.shippingTotal))).toString(),

                      ),
                      CustomTextInRow(
                        mainText: getTranslated(context, "payment_method"),
                        price: orders.paymentMethodTitle,

                      ),
                      CustomTextInRow(
                        mainText: getTranslated(context, "shipping_total"),
                        price: orders.currency+" "+orders.shippingTotal,

                      ),
                      Divider(color: GlobalData.black,),
                      SizedBox(height: 10,),
                      CustomTextInRow(
                        mainText: getTranslated(context, "total"),
                        price: orders.currency+" "+orders.total,

                      ),
                      Divider(color: GlobalData.black,),

                    SizedBox(height: 15,),

                   /* ElevatedButton(onPressed: (){
                      //((int.parse(orders.total))-(int.parse(orders.shippingTotal))).toString()
                      print(((double.parse(orders.total).toInt())-(double.parse(orders.shippingTotal).toInt())).toString());
                      print(double.parse(orders.shippingTotal).toInt());
                      print(orders.total);
                    }, child: Text("ok")),*/
                    Text(getTranslated(context, "shipping_details"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),

                      SizedBox(height: 15,),

                      CustomTextInRow(
                        mainText: getTranslated(context, "name"),
                        price: orders.shipping.firstName+" "+orders.shipping.lastName

                      ),


                      CustomTextInRow(
                          mainText: getTranslated(context, "address"),
                          price: orders.shipping.address1+", "+orders.shipping.city+", "+orders.shipping.state+", "+orders.shipping.country
                          +", \n"+orders.shipping.postcode

                      ),


                      CustomTextInRow(
                          mainText: getTranslated(context, "customer_note"),
                          price: orders.customerNote

                      ),

                      SizedBox(height: 15,),

                      Text(getTranslated(context, "items"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                      SizedBox(height: 10,),
                      ListView.builder(
                        itemCount: orders.lineItems.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),

                        itemBuilder: (c,i){
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Expanded(
                                      child: Text(orders.lineItems[i].name)
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(getTranslated(context, "quantity")+orders.lineItems[i].quantity.toString()),
                                      Text("USD "+orders.lineItems[i].total),
                                    ],
                                  )),
                                ],
                              ),
                              SizedBox(height: 10,),


                            ],
                          );

                        },
                      ),

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: GlobalData.orange, // background
                            // foreground
                          ),
                          onPressed: (){
                            customDialogBox(context,title: getTranslated(context, "cancel_order"),msg:
                            getTranslated(context, "do_you_want_to_cancel_order"),
                                onPressed:(){
                                  deleteOrder();
                                  Navigator.pushNamed(context, "HomePage");
                                  Show_toast_Now("Order Cancelled", Colors.red);

                            });

                          }, child: Text(getTranslated(context, "cancel_order"),style: TextStyle(color: GlobalData.black),))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
