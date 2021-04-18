import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
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
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                CustomOrders(),
                CustomOrders(),
                CustomOrders(),
                CustomOrders(),
                CustomOrders(),
              ],
            ),
          )
        ],
      ),
    );
  }
}




class CustomOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*.07,
              width: MediaQuery.of(context).size.height*.07,
              decoration: BoxDecoration(
                color: GlobalData.orange.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(Icons.home_work_outlined,color: Colors.white,),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height*.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('15 Items',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width*.04
                ),),
                SizedBox(
                  height: MediaQuery.of(context).size.height*.01,
                ),
                Text('5143 Vinings Estates Way\nMABLETON,GA 30126',style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width*.03,
                  color: Colors.grey.withOpacity(0.5)
                ),)
              ],
            ),
            Spacer(),
            Column(
              children: [
                Text('Feb 25,2016',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width*.04
                ),),
                SizedBox(
                  height: MediaQuery.of(context).size.height*.01,
                ),
                Text('\$ 45',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: MediaQuery.of(context).size.width*.08
                ),),
              ],
            )
          ],
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

