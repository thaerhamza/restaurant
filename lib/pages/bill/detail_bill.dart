import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/pages/provider/loading.dart';
import '../config.dart';
import '../function.dart';

import 'detail_billData.dart';

List<DetailBillData> billList = null;
int sum = 0;

class DetailBill extends StatefulWidget {
  final String bil_id;
  final String bil_regdate;
  DetailBill({this.bil_id, this.bil_regdate});
  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<DetailBill> {
  ScrollController myScroll;
  GlobalKey<RefreshIndicatorState> refreshKey;
  int i = 0;
  bool loadingList = false;

  void getDatabill(int count, String strSearch) async {
    loadingList = true;
    setState(() {});
    List arr = await getData(count, 20, "bill/readdetail_bill.php", strSearch,
        "bil_id=${widget.bil_id}&");
    for (int i = 0; i < arr.length; i++) {
      billList.add(new DetailBillData(
        det_id: arr[i]["det_id"],
        foo_id: arr[i]["foo_id"],
        foo_name: arr[i]["foo_name"],
        foo_image: arr[i]["foo_image"],
        det_note: arr[i]["det_note"],
        det_price: arr[i]["det_price"],
        det_qty: arr[i]["det_qty"],
      ));
      sum += int.parse(arr[i]["det_price"]) * int.parse(arr[i]["det_qty"]);
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
    sum = 0;
    _appBarTitle =
        new Text("تفاصيل الطلبية", style: TextStyle(color: Colors.black));
    billList = new List<DetailBillData>();
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
          ),
          body: ListView(
            children: [
              Container(
                height: 130,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("رقم الفاتورة" + " " + widget.bil_id,
                        style: TextStyle(fontFamily: "arial", fontSize: 16)),
                    Text("تاريخ الفاتورة" + " " + widget.bil_regdate,
                        style: TextStyle(fontFamily: "arial", fontSize: 16)),
                    Text("اجمالي الفاتورة" + " " + sum.toString(),
                        style: TextStyle(fontFamily: "arial", fontSize: 16)),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 140,
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
                      return SingleDetailBill(
                        bil_index: index,
                        DetailBill: billList[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class SingleDetailBill extends StatelessWidget {
  int bil_index;
  DetailBillData DetailBill;
  SingleDetailBill({this.bil_index, this.DetailBill});

  bool isloadingFav = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  new Text(
                      "الاجمالي :" +
                          (int.parse(DetailBill.det_qty) *
                                  int.parse(DetailBill.det_price))
                              .toString(),
                      style: TextStyle(fontFamily: "arial", fontSize: 16)),
                  new Text("      "),
                  new Text("السعر : " + DetailBill.det_price,
                      style: TextStyle(
                          fontFamily: "arial",
                          color: Colors.red,
                          fontSize: 16)),
                  new Text(" "),
                  new Text("الكمية :" + DetailBill.det_qty,
                      style: TextStyle(
                          fontFamily: "arial",
                          color: Colors.red,
                          fontSize: 16)),
                  new Text(" "),
                ],
              ),
              new Text(
                DetailBill.foo_name,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
