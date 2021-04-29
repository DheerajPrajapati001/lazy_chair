import 'package:flutter/material.dart';
import 'package:lazy_chair/config/config.dart';

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
         title: Text("Order Details",style: TextStyle(
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
                            child: Text("Order Summary",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
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
                        mainText: "Order Id",
                        price: "#"+orders.id.toString(),

                      ),

                      CustomTextInRow(
                        mainText: "Order Created",
                        price: orders.dateCreated.substring(0,10),

                      ),

                      CustomTextInRow(
                        mainText: "Subtotal",
                        price: orders.currency+" "+((double.parse(orders.total))-(double.parse(orders.shippingTotal))).toString(),

                      ),
                      CustomTextInRow(
                        mainText: "Payment Method",
                        price: orders.paymentMethodTitle,

                      ),
                      CustomTextInRow(
                        mainText: "Shipping Total",
                        price: orders.currency+" "+orders.shippingTotal,

                      ),
                      Divider(color: GlobalData.black,),
                      SizedBox(height: 10,),
                      CustomTextInRow(
                        mainText: "Total",
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
                    Text("Shipping Details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),

                      SizedBox(height: 15,),

                      CustomTextInRow(
                        mainText: "Name",
                        price: orders.shipping.firstName+" "+orders.shipping.lastName

                      ),


                      CustomTextInRow(
                          mainText: "Address",
                          price: orders.shipping.address1+", "+orders.shipping.city+", "+orders.shipping.state+", "+orders.shipping.country
                          +", \n"+orders.shipping.postcode

                      ),


                      CustomTextInRow(
                          mainText: "Customer Note",
                          price: orders.customerNote

                      ),

                      SizedBox(height: 15,),

                      Text("Items",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
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
                                      Text("Quantity "+orders.lineItems[i].quantity.toString()),
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
                            customDialogBox(context,title: "Cancel Order",msg:
                            "Do you want to cancel Order",
                                onPressed:(){
                                  deleteOrder();
                                  Navigator.pushNamed(context, "HomePage");
                                  Show_toast_Now("Order Cancelled", Colors.red);

                            });

                          }, child: Text("Cancel Order",style: TextStyle(color: GlobalData.black),))
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
