import 'package:flutter/material.dart';

class Shipping extends StatefulWidget {

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {

  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: Icon(Icons.arrow_back_ios_outlined), onPressed: (){
                    Navigator.pop(context);
                  }),
                  Text('Shipping',style: TextStyle(fontSize: MediaQuery.of(context).size.width*.06),),
                  IconButton(icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.transparent,),),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            title: 'First Name',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*.05,
                        ),
                        Expanded(
                          child: CustomTextField(
                            title: 'Last Name',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.03,
                    ),
                    CustomTextField(
                      title: 'Address',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.03,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            title: 'City',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*.05,
                        ),
                        Expanded(
                          child: CustomTextField(
                            title: 'ZIP Code',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.03,
                    ),
                    CustomTextField(
                      title: 'Country',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.02,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.black,
                        value: check, onChanged: (a){
                      setState(() {
                        check=a;
                      });
                    }),
                    Text('Save for faster checkout next time',style: TextStyle(color: Colors.black.withOpacity(0.5)),)
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.06,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0,0),
                        spreadRadius: 5,
                        blurRadius: 5
                      )
                    ],
                    borderRadius: BorderRadius.only(topRight: Radius.circular(0),topLeft: Radius.circular(0))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*.01,
                      ),
                      Row(
                        children: [
                          Text(
                            'Additional Shipping Charge',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize:
                                MediaQuery.of(context).size.height * .02),
                          ),
                          Spacer(),
                          Text(
                            '\$5.50',
                            style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.height * .025,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
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
                            '\$149.00',
                            style: TextStyle(
                              color: Colors.orange,
                                fontSize:
                                MediaQuery.of(context).size.height * .025,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*.02,
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
                            onTap: () {
                              Navigator.pushNamed(context, 'Confirmation');
                            },
                            splashColor: Colors.black.withOpacity(0.1),
                            child: Center(
                              child: Text(
                                'Continue To Payment',
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
      ),
    );
  }
}


class CustomTextField extends StatelessWidget {
  final String title;

  const CustomTextField({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: TextStyle(
          fontSize: MediaQuery.of(context).size.width*.04,
          color: Colors.black.withOpacity(0.5)
        ),),
        SizedBox(
          height: MediaQuery.of(context).size.height*.01,
        ),
        Container(
          height: MediaQuery.of(context).size.height*.08,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.3)
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

