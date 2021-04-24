import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_chair/config/config.dart';
import 'package:woocommerce/woocommerce.dart';

import '../global.dart';


class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  WooCommerce wooCommerce = WooCommerce(
    baseUrl: Config.baseUrl,
    consumerKey: Config.key,
    consumerSecret: Config.secret,
    isDebug: true,
  );
  List<WooOrder> orders = [];
  viewOrder()async{
    GlobalData.isLoading=true;
    setState(() {

    });
    orders = await wooCommerce.getOrders(customer: GlobalData.userId,);

    setState(() {

    });
    GlobalData.isLoading=false;
    setState(() {

    });
    print(orders.toString());

    /*await http.get(Config.url+"orders"+"?"+"consumer_key="+Config.key+"&"+"consumer_secret="+Config.secret,

      headers: {"Content-Type": "application/json"},

    ).then((response) {
      var ParsedJson = jsonDecode(response.body);

      print("breakkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
      print(response.body.toString());
      print(orders.length);
      print(GlobalData.nonceKey);
    });*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalData.orange,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          "Orders",
          style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * .045,
              fontWeight: FontWeight.w500),
        ),

        elevation: 0,
      ),
      body: GlobalData.isLoading==true?Center(child: Text("Loading...")):orders.isEmpty?
      Center(child: Text("No Orders")):Column(
        children: [
          /*Container(
            width: MediaQuery.of(context).size.width,
            height: 92,
            color: Colors.black.withOpacity(0.7),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,), onPressed: (){
                    Navigator.pop(context);
                  }),
                  Text('Orders',style: TextStyle(fontSize: MediaQuery.of(context).size.width*.06,color: Colors.white),),
                  IconButton(icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.transparent,),),
                ],
              ),
            ),
          ),*/
          SizedBox(
            height: MediaQuery.of(context).size.height*.02,
          ),

          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (c,i){
                return  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomOrders(
                        totalItems: orders[i].lineItems.length.toString()+" Items",
                        date: "Ordered Date: "+orders[i].dateCreated.substring(0,10),
                        description: "Order Id: "+"#"+orders[i].id.toString(),
                        price: orders[i].total,
                        click: (){
                          GlobalData.orderId=orders[i].id;
                          print(GlobalData.orderId);

                          Navigator.pushNamed(context, 'OrderDetails');

                          setState(() {

                          });

                        },

                      ),

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






class CustomOrders extends StatelessWidget {

  final String totalItems;
  final String description;
  final String date;
  final String price;
  final VoidCallback click;

  CustomOrders({
    this.price,this.description,this.date,this.totalItems,this.click
});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: click,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*.07,
                width: MediaQuery.of(context).size.height*.07,
                decoration: BoxDecoration(
                  color: GlobalData.orange.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.inventory,color: Colors.white,),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.height*.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(totalItems,style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width*.04
                  ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.01,
                  ),
                  Text(description,style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width*.03,
                    color: GlobalData.black
                  ),)
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(date,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width*.04
                  ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.01,
                  ),
                  Text('\$'+price,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: MediaQuery.of(context).size.width*.05
                  ),),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*.02,
        ),
        Divider(
          thickness: 2,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*.02,
        ),
      ],
    );
  }
}

