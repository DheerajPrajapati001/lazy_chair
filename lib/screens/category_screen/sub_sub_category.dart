import 'package:flutter/material.dart';
import 'package:lazy_chair/config/config.dart';
import 'package:lazy_chair/models/product_category.dart';
import 'package:lazy_chair/models/products.dart';
import 'package:lazy_chair/screens/chair_details/chair_details.dart';
import 'package:lazy_chair/screens/products_screen/products_screen.dart';
import '../../woocommerce.dart';
import '../global.dart';

class SubSubCategoryScreen extends StatefulWidget {
  @override
  _SubSubCategoryScreenState createState() => _SubSubCategoryScreenState();
}

class _SubSubCategoryScreenState extends State<SubSubCategoryScreen> {

  List<WooProductCategory> category = [];
  List<WooProduct> products = [];

  WooCommerce wooCommerce = WooCommerce(
    baseUrl: Config.baseUrl,
    consumerKey: Config.key,
    consumerSecret: Config.secret,
    isDebug: true,
  );

  getcategory()async{
    GlobalData.isLoading=true;
    setState(() {

    });
    category = await wooCommerce.getProductCategories(parent: int.parse(GlobalData.categoryId));
    setState(() {

    });
    GlobalData.isLoading=false;
    setState(() {

    });
    print(category.toString());
  }

  getProducts() async{
    GlobalData.isLoading=true;
    setState(() {

    });
    products = await wooCommerce.getProducts(category: GlobalData.categoryId);
    setState(() {
    });
    GlobalData.isLoading=false;
    setState(() {

    });
    print(products.toString());
  }


  @override
  void initState() {
    super.initState();
    //You would want to use a feature builder instead.
    //getProducts();
    getcategory();
    getProducts();

  }

  @override
  Widget build(BuildContext context) {

    Future<void> _onChairPressed(WooProduct products, BuildContext context) async {
      await Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            return ProductDetails(
              productDetails: products,
            );
          },
        ),
      );
    }

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalData.orange,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          category.isEmpty?"Product":"Sub Category",
          style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * .045,
              fontWeight: FontWeight.w500),
        ),

        elevation: 0,
      ),
      body: SafeArea(
        child: GlobalData.isLoading==true?Center(child: Text("Loading...")):category.isEmpty?

            //products//
        CustomScrollView(
          slivers: <Widget>[
            /*SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text('Product',
                  style: Theme.of(context).textTheme.headline.apply(color: Colors.blueGrey),
                ),),
            ),*/
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                mainAxisSpacing: 2,
                crossAxisSpacing: 1,
              ),

              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final product = products[index];
                  return
                    GestureDetector(

                      onTap: ()async{
                        _onChairPressed(product, context);
                        //final myCart = await wooCommerce.addToMyCart(quantity: "1", itemId: product.id.toString());

                        //GlobalData.productId=product.id.toString();
                        //print(product.id);
                        //getsubcategory();
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                //height: 150,
                                //width: 200,
                                //margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage(product.images==null?
                                  "https://beta.saurabhenterprise.com/wp-content/uploads/2021/04/2.png":
                                  product.images[0].src,),
                                      fit: BoxFit.cover),
                                  //color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                //child: Image.network(product.images[0].src, fit: BoxFit.cover,),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Expanded(
                                  flex:8,
                                  child: Text(product.name?? 'Loading...', style: TextStyle(
                                    fontSize: 14,color: GlobalData.black,fontWeight: FontWeight.w500
                                  ),),
                                ),
                                Expanded(
                                  flex:2,
                                    child: Text("\$"+product.price, style: Theme.of(context).textTheme.subtitle,)),

                              ],
                            ),

                            /*RaisedButton(onPressed: (){
                              //Getnonse(Config.tokenURL);
                             //addToMyCartfix(itemId: GlobalData.productId, quantity: "1",);
                              //addToCart();
                              GlobalData.productId=product.id.toString();

                              print(product.id);
                              print("Product Id"+GlobalData.productId);

                            },child: Text("Add to cart"),),


                            //GlobalData.isAdded==true?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RaisedButton(onPressed: (){

                                      print(GlobalData.tokenId);
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewCart()));

                                    },child: Text("View cart"),),
                                  ),
                                  SizedBox(width: 5,),
                                  Expanded(
                                    child: RaisedButton(onPressed: (){
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewOrders()));
                                    },child: Text("View Order"),),
                                  ),
                                ],
                              ),
                            )*/
                            //:Text("")
                          ],
                        ),
                      ),
                    );
                },
                childCount: products.length,
              ),
            )
          ],
        ):

            //Sub sub category//
        CustomScrollView(
          slivers: <Widget>[
            /*SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text('Category',
                  style: Theme.of(context).textTheme.headline.apply(color: Colors.blueGrey),
                ),),
            ),*/
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),

              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final product = category[index];
                  return
                    GestureDetector(

                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsScreen()));

                        print("Category Id:"+category[index].id.toString());
                        GlobalData.categoryId=category[index].id.toString();

                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                        child: Column(

                          children: <Widget>[

                            CircleAvatar(
                              backgroundColor: GlobalData.black.withOpacity(0.2),

                              //child: Text(category[index].name?? 'Loading...', style: Theme.of(context).textTheme.headline6.apply(color: Colors.blueGrey),),
                              radius: 60,
                              backgroundImage: category[index].image==null?NetworkImage("https://beta.saurabhenterprise.com/wp-content/uploads/2021/04/2.png"):
                              NetworkImage(category[index].image.src),

                            ),
                            /*Container(
                              height: 230,
                              width: 200,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(category[index].image==null?"https://beta.saurabhenterprise.com/wp-content/uploads/2021/04/2.png":category[index].image.src,),
                                    fit: BoxFit.cover),
                                color: Colors.pinkAccent,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              //child: Image.network(product.images[0].src, fit: BoxFit.cover,),
                            ),*/
                            Text(category[index].name?? 'Loading...', style: Theme.of(context).textTheme.title.apply(color: Colors.blueGrey),),
                            //Text("\$ 55", style: Theme.of(context).textTheme.subtitle,)
                          ],
                        ),
                      ),
                    );
                },
                childCount: category.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
