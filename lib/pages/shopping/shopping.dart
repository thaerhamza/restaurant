import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  var mypro = [
    {
      "pro_id": "1",
      "pro_name": "مشاوي",
      "pro_price": "100",
      "pro_image": "images/category/cat1.png",
      "pro_qty": "3"
    },
    {
      "pro_id": "1",
      "pro_name": "مشاوي",
      "pro_price": "100",
      "pro_image": "images/category/cat1.png",
      "pro_qty": "3"
    },
    {
      "pro_id": "1",
      "pro_name": "مشاوي",
      "pro_price": "100",
      "pro_image": "images/category/cat1.png",
      "pro_qty": "3"
    },
    {
      "pro_id": "1",
      "pro_name": "مشاوي",
      "pro_price": "100",
      "pro_image": "images/category/cat1.png",
      "pro_qty": "3"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: ListView.builder(
                itemCount: mypro.length,
                itemBuilder: (context, index) {
                  return SingleProduct(
                    pro_id: mypro[index]["pro_id"],
                    pro_name: mypro[index]["pro_name"],
                    pro_image: mypro[index]["pro_image"],
                    pro_qty: mypro[index]["pro_qty"],
                    pro_price: mypro[index]["pro_price"],
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
                        new Text("100.0")
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      children: <Widget>[
                        new Text("دلفري"),
                        new Expanded(child: Text("")),
                        new Text("100.0")
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      children: <Widget>[
                        new Text("الاجمالي الكلي"),
                        new Expanded(child: Text("")),
                        new Text("100.0")
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
                onTap: () {},
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
  final String pro_id;
  final String pro_name;
  final String pro_price;
  final String pro_qty;
  final String pro_image;

  SingleProduct(
      {this.pro_id,
      this.pro_name,
      this.pro_image,
      this.pro_price,
      this.pro_qty});
  @override
  Widget build(BuildContext context) {
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
                pro_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(pro_price),
              leading: Container(
                width: 50.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(pro_image),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              trailing: Container(
                width: 70.0,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
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
                        pro_qty,
                        style: TextStyle(fontSize: 19),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
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
