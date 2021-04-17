import 'package:flutter/material.dart';
import 'package:lazy_chair/chairs.dart';

class ChairDetails extends StatefulWidget {
  final MyChair chair;

  const ChairDetails({Key key, @required this.chair}) : super(key: key);

  @override
  _ChairDetailsState createState() => _ChairDetailsState();
}

class _ChairDetailsState extends State<ChairDetails> {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * .05),
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(Icons.shopping_bag_outlined),
                          onPressed: () {})
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .08,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(widget.chair.bgColor)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.chair.chairName.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height *
                                      .025),
                            ),
                            Spacer(),
                            Text(
                              '\$${widget.chair.price.toInt().toString()}',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * .03,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Text(
                          widget.chair.by.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize:
                                  MediaQuery.of(context).size.height * .02),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.chair.rating.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.height * .02),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '(500+ Review)',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize:
                                      MediaQuery.of(context).size.height * .02),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Row(
                          children: [
                            Text(
                              'Color:',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: MediaQuery.of(context).size.height *
                                      .025),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ChairColors(
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .05,
                            ),
                            ChairColors(
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .05,
                            ),
                            ChairColors(
                              color: Colors.green,
                            ),
                            Spacer(),
                            Container(
                              height: MediaQuery.of(context).size.height * .07,
                              width: MediaQuery.of(context).size.width * .3,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.withOpacity(0.1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                      onTap: __incrementCounter,
                                      child: Text('-',style: TextStyle(fontSize: MediaQuery.of(context).size.height*.07),)),
                                  Text('$_counter'),
                                  GestureDetector(
                                      onTap: _incrementCounter,
                                      child: Icon(Icons.add))
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Text(
                          'Details:',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize:
                                  MediaQuery.of(context).size.height * .025),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .015,
                        ),
                        Text(
                          'Lazy Chair Solid Lorem ipsum dolor sit amet, consetur adipiscing elit. Nunc nunc',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * .025),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .4,
                              height: MediaQuery.of(context).size.height * .08,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5))),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, 'MyCart');
                                  },
                                  child: Center(
                                    child: Text(
                                      'Add To Cart',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: MediaQuery.of(context).size.width * .4,
                              height: MediaQuery.of(context).size.height * .08,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange,
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5))),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, 'Shipping');
                                  },
                                  splashColor: Colors.black.withOpacity(0.1),
                                  child: Center(
                                    child: Text(
                                      'Buy Now',
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
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * .1,
                top: MediaQuery.of(context).size.height * .07,
                child: Image.asset(
                  widget.chair.images.first,
                  height: MediaQuery.of(context).size.height * .3,
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * .08,
                top: MediaQuery.of(context).size.height * .17,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: MediaQuery.of(context).size.width * .06,
                ),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * .18,
                top: MediaQuery.of(context).size.height * .41,
                child: Container(
                  width: MediaQuery.of(context).size.width * .14,
                  height: MediaQuery.of(context).size.height * .12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0,0),
                        blurRadius: 5,
                        spreadRadius: 5
                      )
                    ]
                  ),
                  child: IconButton(icon: Icon(Icons.play_arrow),onPressed: (){},),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChairColors extends StatelessWidget {
  final Color color;

  const ChairColors({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
