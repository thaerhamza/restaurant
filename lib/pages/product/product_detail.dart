import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/pages/config.dart';
import 'package:restaurant/pages/product/productData.dart';
import 'package:restaurant/pages/provider/cart.dart';
import 'package:restaurant/pages/provider/item.dart';
import 'package:restaurant/pages/shopping/shopping.dart';

class ProductDetail extends StatefulWidget {
  final FoodData food;
  ProductDetail({@required this.food});
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Widget headerBuild(Cart mypro) {
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
              child: Stack(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new Shopping()));
                      }),
                  Container(
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: new Text(
                      mypro.getCountItems().toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    myitem = new Item(
        ite_id: widget.food.foo_id,
        ite_name: widget.food.foo_name,
        ite_price: int.parse(widget.food.foo_price),
        ite_image: widget.food.foo_image);
  }

  Item myitem;
  int _qty = 0;
  _minusQty(Cart mypro) {
    if (_qty != 0) {
      _qty = _qty - 1;
      mypro.remove_cart(myitem);
      print("count item is : " + mypro.getCountItems().toString());
    }
  }

  _plusQty(Cart mypro) {
    _qty = _qty + 1;
    mypro.add_cart(myitem);
    print("count item is : " + mypro.getCountItems().toString());
  }

  Widget imageProduct(Cart mypro) {
    _qty = mypro.getCountByItem(myitem);
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[100],
                spreadRadius: 1,
                blurRadius: 0,
                offset: Offset(0, 1))
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0))),
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: imagesFood + widget.food.foo_image,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Padding(padding: EdgeInsets.only(top: 30.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //==========================back
              Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[100],
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1))
                      ],
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.minus,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _minusQty(mypro);
                      })),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    _qty.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                  )),
//=======================shopping cart
              Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[100],
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1))
                      ],
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.plus,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _plusQty(mypro);
                      })),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var myprovider = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            ListView(
              children: <Widget>[
                imageProduct(myprovider),
                Container(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        widget.food.foo_name,
                        style: TextStyle(fontSize: 30.0),
                      ),
                      Row(
                        children: [
                          new Text(
                            "السعر ",
                            style: TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                          new Text(
                            widget.food.foo_price,
                            style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: "Arial",
                                color: Colors.red),
                          ),
                          new Text(
                            currency,
                            style: TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Icon(Icons.favorite, color: Colors.red),
                          new Text(
                            "5",
                            style: TextStyle(fontSize: 16),
                          ),
                          new Expanded(child: Text("")),
                          new Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          new Text(
                            "5 review",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 15.0)),
                      new Text(
                        widget.food.foo_info,
                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              height: 120.0,
              child: headerBuild(myprovider),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: Row(
          children: <Widget>[
            new Text(
              "1500",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(child: Text("")),
            Container(
              decoration: BoxDecoration(
                  color: Colors.red[200],
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[100],
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1))
                  ],
                  borderRadius: BorderRadius.circular(40)),
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "اضافة الى السلة",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Container(
              child: Icon(
                Icons.shopping_basket,
                color: Colors.white,
              ),
            ),
          ],
        ),
        padding: EdgeInsets.only(left: 50, right: 30),
        height: 75.0,
        decoration: BoxDecoration(
            //color: Colors.red[300],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.red,
                  Colors.red[300],
                  Colors.red[300],
                  Colors.red,
                ]),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[100],
                  spreadRadius: 7,
                  blurRadius: 4,
                  offset: Offset(0, 3))
            ],
            borderRadius: BorderRadius.circular(40)),
      ),
    );
  }
}
