import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/pages/component/progress.dart';
import 'package:restaurant/pages/product/productData.dart';
import 'package:restaurant/pages/product/product_detail.dart';
import 'package:restaurant/pages/provider/loading.dart';

import '../config.dart';
import '../function.dart';

List<FoodData> foodList = null;

class Product extends StatefulWidget {
  final String cat_id;
  final String cat_name;
  Product({this.cat_id, this.cat_name});
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  ScrollController myScroll;
  GlobalKey<RefreshIndicatorState> refreshKey;
  int i = 0;
  bool loadingList = false;

  void getDataFood(int count, String strSearch) async {
    loadingList = true;
    setState(() {});
    List arr = await getData(count, 20, "food/readfoodcustomer.php", strSearch,
        "cat_id=${widget.cat_id}&cus_id=${G_cus_id_val}&");
    for (int i = 0; i < arr.length; i++) {
      foodList.add(new FoodData(
        foo_id: arr[i]["foo_id"],
        cat_id: arr[i]["cat_id"],
        foo_name: arr[i]["foo_name"],
        foo_name_en: arr[i]["foo_name_en"],
        foo_price: arr[i]["foo_price"],
        foo_offer: arr[i]["foo_offer"],
        foo_info: arr[i]["foo_info"],
        foo_info_en: arr[i]["foo_info_en"],
        fav_id: arr[i]["fav_id"],
        foo_regdate: arr[i]["foo_regdate"],
        foo_thumbnail: arr[i]["foo_thumbnail"],
        foo_image: arr[i]["foo_image"],
      ));
    }
    loadingList = false;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myScroll.dispose();
    foodList.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appBarTitle =
        new Text(widget.cat_name, style: TextStyle(color: Colors.black));
    foodList = new List<FoodData>();
    myScroll = new ScrollController();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    getDataFood(0, "");

    myScroll.addListener(() {
      if (myScroll.position.pixels == myScroll.position.maxScrollExtent) {
        i += 20;
        getDataFood(i, "");
        print("scroll");
      }
    });
  }

  Icon _searchIcon = new Icon(
    Icons.search,
    color: Colors.black,
  );
  Widget _appBarTitle;

  void _searchPressed(LoadingControl myProv) {
    if (this._searchIcon.icon == Icons.search) {
      this._searchIcon = new Icon(Icons.close);
      this._appBarTitle = new TextField(
        style: TextStyle(color: Colors.white),
        decoration: new InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: "ابحث ..."),
        onChanged: (text) {
          print(text);

          foodList.clear();
          i = 0;
          getDataFood(0, text);
          myProv.add_loading();
        },
      );
    } else {
      this._searchIcon = new Icon(Icons.search);
      this._appBarTitle = new Text(
        "بحث باسم المأكولات",
        style: TextStyle(color: Colors.black),
      );
    }
    myProv.add_loading();
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<LoadingControl>(context);
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: _appBarTitle,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            centerTitle: true,
            actions: [
              Container(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    _searchPressed(myProvider);
                  },
                  child: _searchIcon,
                ),
              )
            ],
          ),
          body: Container(
            child: RefreshIndicator(
              onRefresh: () async {
                i = 0;
                foodList.clear();
                await getDataFood(0, "");
              },
              key: refreshKey,
              child: ListView.builder(
                controller: myScroll,
                itemCount: foodList.length,
                itemBuilder: (context, index) {
                  return SingleProduct(
                    foo_index: index,
                    food: foodList[index],
                  );
                },
              ),
            ),
          )),
    );
  }
}

class SingleProduct extends StatelessWidget {
  int foo_index;
  FoodData food;
  SingleProduct({this.foo_index, this.food});

  bool isloadingFav = false;
  saveFavorite(String fav_id, String foo_id, int foo_idex, context,
      LoadingControl load) async {
    if (fav_id != null) {
      //delete favorite
      bool res =
          await deleteData("fav_id", fav_id, "favorite/delete_favorite.php");
      isloadingFav = res;
      if (isloadingFav) {
        foodList[foo_index].fav_id = null;
        load.add_loading();
      }
    } else {
      //insert favorite
      Map arr = {"cus_id": G_cus_id_val, "foo_id": foo_id};
      Map resArray = await SaveDataList(
          arr, "favorite/insert_favorite.php", context, "insert");
      isloadingFav = resArray != null ? true : false;
      if (isloadingFav) {
        foodList[foo_index].fav_id = resArray["fav_id"];
        load.add_loading();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(5.0)),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetail(
                            food: food,
                          )));
            },
            child: Container(
              margin: EdgeInsets.only(right: 5.0),
              height: 100.0,
              width: 100.0,
              child: CachedNetworkImage(
                imageUrl: imagesFood +
                    (food.foo_thumbnail == null || food.foo_thumbnail == ""
                        ? "def.png"
                        : food.foo_thumbnail),
                imageBuilder: (context, imageProvider) => Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetail(
                              food: food,
                            )));
              },
              child: Container(
                height: 100.0,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      food.foo_name,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    new RichText(
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      text: TextSpan(children: [
                        TextSpan(
                          text: food.foo_info,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //=========================favorite
          Container(
            height: 100.0,
            width: 50.0,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Consumer<LoadingControl>(builder: (context, load, child) {
                  return isloadingFav
                      ? circularProgress()
                      : GestureDetector(
                          onTap: () {
                            saveFavorite(food.fav_id, food.foo_id, foo_index,
                                context, load);
                          },
                          child: new Icon(
                            (food.fav_id == null
                                ? Icons.favorite_border
                                : Icons.favorite),
                            color: (food.fav_id == null
                                ? Colors.black
                                : Colors.red),
                          ),
                        );
                }),
                checkOffer(food.foo_offer)
              ],
            ),
          )
          //=========================end favorite
        ],
      ),
    );
  }

  Widget checkOffer(String foo_offer) {
    return foo_offer == "1"
        ? Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.red,
            ),
            child: new Text(
              "عرض",
              style: TextStyle(color: Colors.white),
            ))
        : Text("");
  }
}
