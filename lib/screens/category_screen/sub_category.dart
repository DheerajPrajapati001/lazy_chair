import 'package:flutter/material.dart';
import 'package:lazy_chair/config/config.dart';
import 'package:lazy_chair/localization/language_constants.dart';
import 'package:lazy_chair/models/product_category.dart';
import 'package:lazy_chair/screens/category_screen/sub_sub_category.dart';

import '../../woocommerce.dart';
import '../global.dart';

class SubCategoryScreen extends StatefulWidget {
  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {

  List<WooProductCategory> category = [];
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

  @override
  void initState() {
    super.initState();
    //You would want to use a feature builder instead.
    //getProducts();
    getcategory();

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalData.orange,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          getTranslated(context, "sub_category")!,
          style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * .045,
              fontWeight: FontWeight.w500),
        ),

        elevation: 0,
      ),
      body: SafeArea(
        child: GlobalData.isLoading==true?Center(child: Text("Loading...")):category.isEmpty?
        Center(child: Text(getTranslated(context, "empty_category_list")!)):
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SubSubCategoryScreen()));
                        // Navigator.of(context).pushNamed("subCategory");
                        //wooCommerce.addToMyCart(itemId: product.id.toString(), quantity: "1");
                        print("Category Id:"+category[index].id.toString());
                        GlobalData.categoryId=category[index].id.toString();
                        //getsubcategory();
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
                              NetworkImage(category[index].image!.src!),

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
                            Text(category[index].name?? 'Loading...', style: Theme.of(context).textTheme.titleLarge!.apply(color: Colors.blueGrey),),
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
