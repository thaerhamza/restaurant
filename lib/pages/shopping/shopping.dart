import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/pages/account/myprofile.dart';
import 'package:restaurant/pages/function.dart';
import 'package:restaurant/pages/home/home.dart';
import 'package:restaurant/pages/provider/cart.dart';
import 'package:restaurant/pages/provider/item.dart';

import '../config.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  Widget headerBuild() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          //==========================back
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[100],
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1))
                  ],
                  borderRadius: BorderRadius.circular(15)),
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })),
          Expanded(child: Text("")),
//=======================shopping cart
        ],
      ),
    );
  }

  saveCart(context, Cart myPro) async {
    Map arr = {
      "data": myPro.getStringCart(),
      "cus_id": G_cus_id_val,
      "bil_address": "",
      "bil_before_note": ""
    };

    var res = await SaveData(
        arr, "bill/insert_bill.php", context, () => Home(), "insert");
    myPro.clearCart();
  }

  void _showSheetMessage(context, Cart myPro) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        context: context,
        builder: (BuildContext bc) {
          return Container(
              child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
                      child:
                          new Icon(Icons.done, size: 55.0, color: Colors.red)),
                  new Text(
                    "شكرا لطلبك",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  ),
                  new Text(
                    "يمكنك تتبع الطلبية من خلال الضغط على الزر في الاسفل",
                    style: TextStyle(color: Colors.grey, fontSize: 16.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: MaterialButton(
                        child: Container(
                          margin: EdgeInsets.all(15.0),
                          width: MediaQuery.of(context).size.width,
                          child: Text("تابع الطلبية",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              )),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          saveCart(context, myPro);
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: MaterialButton(
                        child: Container(
                          margin: EdgeInsets.all(15.0),
                          width: MediaQuery.of(context).size.width,
                          child: Text("الانتقال الى المأكولات",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                              )),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {}),
                  )
                ],
              )
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<Cart>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: ListView.builder(
                itemCount: myProvider.listItems().length,
                itemBuilder: (context, index) {
                  return SingleProduct(
                    index: index,
                    item: myProvider.listItems()[index],
                  );
                },
              ),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              height: 120.0,
              child: headerBuild(),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 210.0,
        child: Column(
          children: <Widget>[
            Card(
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        new Text("اجمالي المبلغ"),
                        new Expanded(child: Text("")),
                        new Text(myProvider.totalItems().toString())
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      children: <Widget>[
                        new Text("دلفري"),
                        new Expanded(child: Text("")),
                        new Text("0")
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      children: <Widget>[
                        new Text("الاجمالي الكلي"),
                        new Expanded(child: Text("")),
                        new Text(myProvider.totalItems().toString())
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5.0),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  "اضافة الى السلة",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              height: 40.0,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(40)),
            ),
            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  _showSheetMessage(context, myProvider);
                },
                child: Text(
                  "تأكيد الطلبية",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              height: 40.0,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(40)),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleProduct extends StatelessWidget {
  final int index;
  final Item item;

  SingleProduct({this.item, this.index});
  @override
  Widget build(BuildContext context) {
    var mypro = Provider.of<Cart>(context);
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          ),
          Container(
            child: ListTile(
              title: Text(
                item.ite_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(item.ite_price.toString()),
              leading: Container(
                margin: EdgeInsets.only(right: 5.0),
                height: 100.0,
                width: 100.0,
                child: CachedNetworkImage(
                  imageUrl: imagesFood +
                      (item.ite_image == null || item.ite_image == ""
                          ? "def.png"
                          : item.ite_image),
                  imageBuilder: (context, imageProvider) => Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              trailing: Container(
                width: 70.0,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        mypro.add_cart(item);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                          size: 16,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                    Expanded(
                      child: new Text(
                        mypro.getCountByItem(item).toString(),
                        style: TextStyle(fontSize: 19),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        mypro.remove_cart(item);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: FaIcon(
                          FontAwesomeIcons.minus,
                          color: Colors.white,
                          size: 16,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
