import 'package:flutter/material.dart';
import 'package:restaurant/pages/account/register.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  @override
  Widget build(BuildContext context) {
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
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 35.0),
                        child: Text(
                          "نسيت كلمة المرور ",
                          style: TextStyle(fontSize: 25.0, color: Colors.red),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 35.0),
                        child: Text(
                          "قم بادخال الايميل الصحيح ليتم ارسال كلمة المرور اليك ",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "البريد الالكتروني",
                              border: InputBorder.none),
                          validator: (String value) {
                            if (value.isEmpty ||
                                value.indexOf(".") == -1 ||
                                value.indexOf("@") == -1) {
                              return "الرجاء ادخال البريد الالكتروني";
                            }
                          },
                        ),
                      ),
                      MaterialButton(
                          onPressed: () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "ارسال",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                            margin: EdgeInsets.only(bottom: 10.0, top: 30.0),
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(25.0)),
                          )),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ));
  }
}
