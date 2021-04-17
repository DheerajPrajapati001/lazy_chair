import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lazy_chair/chairs.dart';
import 'package:lazy_chair/screens/chair_details/chair_details.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _onChairPressed(MyChair chair, BuildContext context) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return ChairDetails(
            chair: chair,
          );
        },
      ),
    );
  }

  String disp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'You Choice Cute Chair',
          style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * .045,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          Row(
            children: [
              Icon(Icons.notifications_none),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ],
        elevation: 0,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*.25,
              color: Colors.orangeAccent,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height*.1,
                        height: MediaQuery.of(context).size.height*.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.add_a_photo_outlined,),onPressed: (){},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*.01,
                      ),
                      Text('Ana Skulj',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height*.045
                      ),)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.1),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.04,
                  ),
                  DrawerItem(
                    icon: Icons.person_outline_outlined,
                    title: 'Profile',
                  ),
                  DrawerItem(
                    icon: Icons.message_outlined,
                    title: 'Messages',
                  ),
                  DrawerItem(
                    icon: Icons.local_activity_outlined,
                    title: 'Activity',
                  ),
                  DrawerItem(
                    icon: Icons.report_gmailerrorred_outlined,
                    title: 'Report',
                  ),
                  DrawerItem(
                    icon: Icons.exit_to_app_sharp,
                    title: 'Sign Out',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: Offset(0, 0),
              spreadRadius: 10,
              blurRadius: 10)
        ]),
        child: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 300),
          color: Colors.white,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.orangeAccent,
          index: 0,
          items: <Widget>[
            Icon(Icons.home),
            Icon(Icons.category),
            Icon(Icons.shopping_cart_sharp),
            Icon(Icons.settings),
          ],
          onTap: (index) {
            setState(() {
              if(index==0){
                disp = 'home';
                HomeScreen();
              }else if(index==1){
                disp = 'categories';
                var color = Colors.red;
              }else if(index==2){
                disp = 'Cart';
                var color = Colors.yellow;
              }else{
                disp = 'Settings';
                var color = Colors.green;
              }
            });
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              // Row(
              //   children: [
              //     Icon(Icons.menu_open),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Hey, Masrafi!',
              //           style: TextStyle(
              //               color: Colors.grey,
              //               fontSize: MediaQuery.of(context).size.width * .04),
              //         ),
              //         Text(
              //           'You Choice Cute Chair',
              //           style: TextStyle(
              //               color: Colors.black,
              //               fontSize: MediaQuery.of(context).size.width * .045,
              //               fontWeight: FontWeight.w500),
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Icon(Icons.notifications_none)
              //   ],
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .08,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          suffixIcon: Icon(Icons.search)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .2,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.orangeAccent.withOpacity(0.8),
                      Colors.orange
                    ], end: Alignment.centerRight, begin: Alignment.centerLeft),
                    borderRadius: BorderRadius.circular(10)),
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
                              fontSize:
                                  MediaQuery.of(context).size.width * .05),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Text(
                          '30%',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * .1),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Text(
                          'Discount',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * .07),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .1,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Row(
                children: [
                  Text(
                    'Popular Chair',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
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
                height: MediaQuery.of(context).size.height * .04,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: chair.length,
                  padding: EdgeInsets.only(right: 10),
                  itemBuilder: (context, index) {
                    final chairItem = chair[index];
                    return ChairItem(
                      chairItem: chairItem,
                      onTap: () {
                        _onChairPressed(chairItem, context);
                      },
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
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: MediaQuery.of(context).size.height * .05,
          width: MediaQuery.of(context).size.width * .55,
          decoration: BoxDecoration(
              color: Color(chairItem.bgColor),
              borderRadius: BorderRadius.circular(50)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      chairItem.images.first,
                      height: MediaQuery.of(context).size.height * .15,
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  chairItem.chairName.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * .025),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Text(
                  chairItem.by.toString(),
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: MediaQuery.of(context).size.height * .02),
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
                    Text(
                      chairItem.rating.toString(),
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .02),
                    ),
                    Spacer(),
                    Text(
                      '\$${chairItem.price.toInt().toString()}',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .03,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class DrawerItem extends StatelessWidget {

  final String title;
  final IconData icon;

  const DrawerItem({Key key, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Icon(icon,color: Colors.grey,size: MediaQuery.of(context).size.height*.035,),
              SizedBox(
                width: MediaQuery.of(context).size.width*.07,
              ),
              Text(title,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height*.025
              ),)
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*.015,
        )
      ],
    );
  }
}

