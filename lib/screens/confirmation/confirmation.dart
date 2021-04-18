import 'package:flutter/material.dart';

import '../global.dart';

class Confirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: Icon(Icons.arrow_back_ios_outlined), onPressed: (){
                  Navigator.pop(context);
                }),
                Text('Confirmation',style: TextStyle(fontSize: MediaQuery.of(context).size.width*.06),),
                IconButton(icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.transparent,),),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Icon(Icons.shopping_bag_outlined,size: MediaQuery.of(context).size.height*.1,),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.03,
                    ),
                    Text('Hey Kazi,\nThanks for your purchase',textAlign: TextAlign.center,style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*.025
                    ),),
                  ],
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.01,
                  ),
                  CustomRow(
                    text: 'Sub Total',
                    price: '138.75',
                  ),
                  CustomRow(
                    text: 'VAT(15%)',
                    price: '5.50',
                  ),
                  CustomRow(
                    text: 'Shipping Charge',
                    price: '5.50',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.01,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.01,
                  ),
                  Row(
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize:
                            MediaQuery.of(context).size.height * .02),
                      ),
                      Spacer(),
                      Text(
                        '\$149.00',
                        style: TextStyle(
                            color: GlobalData.orange,
                            fontSize:
                            MediaQuery.of(context).size.height * .025,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.03,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.7),
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.5))),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                        },
                        splashColor: Colors.black.withOpacity(0.1),
                        child: Center(
                          child: Text(
                            'Order Details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.02,
                  ),
                  Text(
                    'Order #UPS36237',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize:
                        MediaQuery.of(context).size.height * .022),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .08,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: GlobalData.orange,
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5))),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                    },
                    splashColor: Colors.black.withOpacity(0.1),
                    child: Center(
                      child: Text(
                        'Continue Shopping',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class CustomRow extends StatelessWidget {

  final String text;
  final String price;

  const CustomRow({Key key, this.text, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              text,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize:
                  MediaQuery.of(context).size.height * .022),
            ),
            Spacer(),
            Text(
              '\$'+price,
              style: TextStyle(
                  color: Colors.black,
                  fontSize:
                  MediaQuery.of(context).size.height * .024,),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*.01,
        ),
      ],
    );
  }
}

