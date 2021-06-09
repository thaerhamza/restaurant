import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/pages/bill/detail_bill.dart';
import 'package:restaurant/pages/provider/loading.dart';
import '../config.dart';
import '../function.dart';
import 'billData.dart';

List<BillData> billList = null;

class Bill extends StatefulWidget {
  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {
  ScrollController myScroll;
  GlobalKey<RefreshIndicatorState> refreshKey;
  int i = 0;
  bool loadingList = false;

  void getDatabill(int count, String strSearch) async {
    loadingList = true;
    setState(() {});
    List arr = await getData(
        count, 20, "bill/readbill.php", strSearch, "cus_id=${G_cus_id_val}&");
    for (int i = 0; i < arr.length; i++) {
      billList.add(new BillData(
        bil_id: arr[i]["bil_id"],
        cus_id: arr[i]["cus_id"],
        bil_address: arr[i]["bil_address"],
        del_id: arr[i]["del_id"],
        bil_regdate: arr[i]["bil_regdate"],
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
    billList.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appBarTitle = new Text("الطلبيات", style: TextStyle(color: Colors.black));
    billList = new List<BillData>();
    myScroll = new ScrollController();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    getDatabill(0, "");

    myScroll.addListener(() {
      if (myScroll.position.pixels == myScroll.position.maxScrollExtent) {
        i += 20;
        getDatabill(i, "");
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

          billList.clear();
          i = 0;
          getDatabill(0, text);
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
                billList.clear();
                await getDatabill(0, "");
              },
              key: refreshKey,
              child: ListView.builder(
                controller: myScroll,
                itemCount: billList.length,
                itemBuilder: (context, index) {
                  return SingleBill(
                    bil_index: index,
                    bill: billList[index],
                  );
                },
              ),
            ),
          )),
    );
  }
}

class SingleBill extends StatelessWidget {
  int bil_index;
  BillData bill;
  SingleBill({this.bil_index, this.bill});

  bool isloadingFav = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailBill(
                      bil_id: bill.bil_id,
                      bil_regdate: bill.bil_regdate,
                    )));
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Text(
                bill.bil_regdate,
                style: TextStyle(
                    fontFamily: "arial", fontSize: 16, color: Colors.grey),
              ),
              Row(
                children: [
                  new Text(
                    bill.bil_id,
                    style: TextStyle(
                        fontFamily: "arial", color: Colors.red, fontSize: 16),
                  ),
                  new Text("  "),
                  new Text("رقم الفاتورة"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
