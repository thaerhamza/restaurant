import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/pages/account/login.dart';
import 'package:restaurant/pages/component/progress.dart';
import 'package:restaurant/pages/home/home.dart';
import 'package:restaurant/pages/provider/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../config.dart';
import '../function.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isloading = false;

  var _formKey = GlobalKey<FormState>();
  TextEditingController txtcus_name = new TextEditingController();
  TextEditingController txtcus_pwd = new TextEditingController();
  TextEditingController txtcus_mobile = new TextEditingController();

  TextEditingController txtcus_email = new TextEditingController();

  saveDataCustomer(context, LoadingControl load) async {
    if (!await checkConnection()) {
      Toast.show("Not connected Internet", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
    bool myvalid = _formKey.currentState.validate();
    load.add_loading();
    if (myvalid) {
      isloading = true;
      load.add_loading();
      Map arr = {
        "cus_name": txtcus_name.text,
        "cus_pwd": txtcus_pwd.text,
        "cus_mobile": txtcus_mobile.text,
        "cus_email": txtcus_email.text,
      };

      Map resArray = await SaveDataList(
          arr, "customer/insert_customer.php", context, "insert");
      isloading = resArray != null ? true : false;
      if (isloading) {
        SharedPreferences sh = await SharedPreferences.getInstance();
        sh.setString(G_cus_id, resArray["cus_id"]);
        sh.setString(G_cus_name, resArray["cus_name"]);
        sh.setString(G_cus_image, resArray["cus_image"]);
        sh.setString(G_cus_mobile, resArray["cus_mobile"]);
        sh.setString(G_cus_email, resArray["cus_email"]);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
      /*await createData(
          arr, "delivery/insert_delivery.php", context, () => Delivery());*/

      load.add_loading();
    } else {
      Toast.show("Please fill data", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtcus_name.dispose();
    txtcus_pwd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<LoadingControl>(context);

    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop()),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "انشاء حساب ",
                          style: TextStyle(fontSize: 25.0, color: Colors.red),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 30.0),
                        child: Text(
                          "جديد ",
                          style: TextStyle(fontSize: 25.0, color: Colors.red),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TextFormField(
                          controller: txtcus_name,
                          decoration: InputDecoration(
                              hintText: "الاسم الكامل",
                              border: InputBorder.none),
                          validator: (String value) {
                            if (value.isEmpty || value.length < 1) {
                              return "الرجاء ادخال الاسم الكامل";
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TextFormField(
                          controller: txtcus_email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "البريد الالكتروني",
                              border: InputBorder.none),
                          validator: (String value) {
                            if (value.isEmpty &&
                                (value.indexOf(".") == -1 ||
                                    value.indexOf("@") == -1)) {
                              return "الرجاء ادخال البريد الالكتروني";
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TextFormField(
                          controller: txtcus_pwd,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "كلمة المرور",
                              border: InputBorder.none),
                          validator: (String value) {
                            if (value.isEmpty || value.length < 6) {
                              return "الرجاء ادخال كلمة المرور";
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TextFormField(
                          controller: txtcus_mobile,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "رقم الهاتف", border: InputBorder.none),
                          validator: (String value) {
                            if (value.isEmpty || value.length < 5) {
                              return "الرجاء ادخال رقم الهاتف";
                            }
                          },
                        ),
                      ),
                      isloading
                          ? circularProgress()
                          : MaterialButton(
                              onPressed: () {
                                saveDataCustomer(context, myProvider);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "تسجيل",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                margin:
                                    EdgeInsets.only(bottom: 10.0, top: 30.0),
                                padding: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(25.0)),
                              )),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        alignment: Alignment.bottomCenter,
                        child: Text(
                            "عند الضغط على الشروط والاحكام انت توافق على قوانين التطبيق"),
                      )
                    ],
                  ),
                )),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "اذا لديك حساب سجل الدخول ؟",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      Padding(padding: EdgeInsets.all(10.0)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text("دخول",
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.0)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
