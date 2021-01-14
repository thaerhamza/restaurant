import 'package:flutter/material.dart';
import 'package:restaurant/pages/product/subcategory.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  var myarr_category = [
    {
      "cat_id": "1",
      "cat_name": "مأكولات بحرية",
      "cat_image": "images/category/cat1.png"
    },
    {
      "cat_id": "2",
      "cat_name": "مقبلات",
      "cat_image": "images/category/cat2.png"
    },
    {
      "cat_id": "3",
      "cat_name": "مشاوي",
      "cat_image": "images/category/cat3.png"
    },
    {
      "cat_id": "4",
      "cat_name": "cat4",
      "cat_image": "images/category/cat4.png"
    },
    {
      "cat_id": "5",
      "cat_name": "cat5",
      "cat_image": "images/category/cat5.png"
    },
    {
      "cat_id": "6",
      "cat_name": "cat6",
      "cat_image": "images/category/cat6.png"
    },
    {
      "cat_id": "7",
      "cat_name": "cat7",
      "cat_image": "images/category/cat7.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "قائمة المأكولات",
          style: TextStyle(color: Colors.black),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: ListView.builder(
            itemCount: myarr_category.length,
            itemBuilder: (BuildContext context, int index) {
              return SingleCategory(
                  cat_id: myarr_category[index]["cat_id"],
                  cat_image: myarr_category[index]["cat_image"],
                  cat_name: myarr_category[index]["cat_name"]);
            }),
      ),
    );
  }
}

class SingleCategory extends StatelessWidget {
  final String cat_id;
  final String cat_name;
  final String cat_image;

  SingleCategory({this.cat_id, this.cat_name, this.cat_image});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new SubCategory(
                            cat_id: cat_id,
                            cat_name: cat_name,
                          )));
            },
            child: ListTile(
              leading: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.red[100]),
                child: Image.asset(cat_image),
              ),
              title: Text(
                cat_name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
