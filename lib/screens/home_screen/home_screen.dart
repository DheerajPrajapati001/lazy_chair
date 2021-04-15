import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lazy_chair/chairs.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: Offset(0,0),
              spreadRadius: 10,
              blurRadius: 10
            )
          ]
        ),
        child: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 300),
          color: Colors.white,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.orangeAccent,
          animationCurve: Curves.easeInCubic,
          index: 2,
          items: <Widget>[
            Icon(Icons.home),
            Icon(Icons.shopping_bag_outlined),
            Icon(Icons.fingerprint),
            Icon(Icons.favorite_border),
            Icon(Icons.person_sharp),
          ],
          onTap: (index) {
            debugPrint("Current Index is $index");
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*.01,
              ),
              Row(
                children: [
                  Icon(Icons.menu_open),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Hey, Masrafi!',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width * .04),
                      ),
                      Text(
                        'You Choice Cute Chair',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * .045,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.notifications_none)
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.04,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.08,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        suffixIcon: Icon(Icons.search)
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.03,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.2,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orangeAccent.withOpacity(0.8),Colors.orange],
                      end: Alignment.centerRight,
                      begin: Alignment.centerLeft
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hot Offer',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: MediaQuery.of(context).size.width * .05),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*.01,
                        ),
                        Text(
                          '30%',
                          style: TextStyle(
                              color: Colors.white,fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * .1),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*.01,
                        ),
                        Text(
                          'Discount',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width * .07),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*.1,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.03,
              ),
              Row(
                children: [
                  Text(
                    'Popular Chair',
                    style: TextStyle(
                        color: Colors.black,fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * .05),
                  ),
                  Spacer(),
                  Text(
                    'See All',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: MediaQuery.of(context).size.width * .04),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.04,
              ),
              Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: chair.length,
                    padding: EdgeInsets.only(right: 10),
                    itemBuilder: (context, index){
                      final chairItem = chair[index];
                      return ChairItem(
                        chairItem: chairItem,
                        onTap: (){},
                      );
                    },
                  ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}


class ChairItem extends StatelessWidget {

  final MyChair chairItem;
  final VoidCallback onTap;

  const ChairItem({Key key, this.chairItem, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Container(
          height: MediaQuery.of(context).size.height*.05,
          width: MediaQuery.of(context).size.width*.55,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      chairItem.images.first,
                      height: MediaQuery.of(context).size.height*.15,
                    ),
                  ],
                ),
               Spacer(),
                Text(chairItem.chairName.toString(),style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height*.025
                ),),
                SizedBox(
                  height: MediaQuery.of(context).size.height*.01,
                ),
                Text(chairItem.by.toString(),style: TextStyle(
                  color: Colors.grey,
                    fontSize: MediaQuery.of(context).size.height*.02
                ),),
                SizedBox(
                  height: MediaQuery.of(context).size.height*.01,
                ),
                Row(
                  children: [
                    Icon(Icons.star,color: Colors.orangeAccent,),
                    Text(chairItem.rating.toString(),style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*.02
                    ),),
                    Spacer(),
                    Text('\$${chairItem.price.toInt().toString()}',style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*.03,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




