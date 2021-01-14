import 'package:flutter/material.dart';
import 'package:restaurant/pages/account/forgetPassword.dart';
import 'package:restaurant/pages/account/register.dart';
import 'package:restaurant/pages/home/home.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
                          "تغيير كلمة المرور ",
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
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: " كلمة المرور الحالية",
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
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "كلمة المرور الجديدة",
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
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "تأكيد كلمة المرور",
                              border: InputBorder.none),
                          validator: (String value) {
                            if (value.isEmpty || value.length < 6) {
                              return "الرجاء ادخال كلمة المرور";
                            }
                          },
                        ),
                      ),
                      MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new Home()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "حفظ",
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
