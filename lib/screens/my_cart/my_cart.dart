import 'package:flutter/material.dart';
import 'package:lazy_chair/chairs.dart';
import 'package:lazy_chair/images.dart';

class MyCart extends StatefulWidget {

  final MyChair chair;

  const MyCart({Key key, this.chair}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
      print('$_counter');
    });
  }
  void __incrementCounter() {
    setState(() {
      _counter--;
      print('$_counter');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5,right: 10,top: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      //Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Details',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * .05),
                  ),
                  Spacer(),
                  Text(
                    'Edit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * .05),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2 Items',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize:
                        MediaQuery.of(context).size.height * .025),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.02,
                  ),
                  Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*.15,
                        width: MediaQuery.of(context).size.height*.15,
                        decoration: BoxDecoration(
                          color: Color(0xFFDBF3FA),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Image.asset(MyImage.chair1,height: MediaQuery.of(context).size.height*.1,),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Lazy Bean Chair',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width * .05),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*.005,
                          ),
                          Text(
                            'By Daud',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                MediaQuery.of(context).size.height * .02),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*.02,
                          ),
                          Row(
                            children: [
                              Text(
                                'Qty:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.of(context).size.width * .04),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*.08,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                      onTap: __incrementCounter,
                                      child: Text('-',style: TextStyle(fontSize: MediaQuery.of(context).size.height*.07,color: Colors.red),),),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*.04,
                                  ),
                                  Text('$_counter',style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*.05),),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*.04,
                                  ),
                                  GestureDetector(
                                      onTap: _incrementCounter,
                                      child: Icon(Icons.add,color: Colors.red,))
                                ],
                              ),

                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height*.06,
                          ),
                          Text(
                            '\$120',
                            style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.height * .025,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.02,
                    ),
                    Row(
                      children: [
                        Text(
                          'Subtotal',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize:
                              MediaQuery.of(context).size.height * .02),
                        ),
                        Spacer(),
                        Text(
                          '\$120',
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.height * .025,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.01,
                    ),
                    Row(
                      children: [
                        Text(
                          'Shipping Free',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize:
                              MediaQuery.of(context).size.height * .02),
                        ),
                        Spacer(),
                        Text(
                          '\$2',
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.height * .025,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.03,
                    ),
                    Divider(
                      color: Colors.black,
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
                          '\$122',
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.height * .025,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.05,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange,
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.5))),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.black.withOpacity(0.1),
                          child: Center(
                            child: Text(
                              'Proceed To Buy',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
