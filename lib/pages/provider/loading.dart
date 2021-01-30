import 'package:flutter/material.dart';

class LoadingControl with ChangeNotifier {
  void add_loading() {
    notifyListeners();
  }
}
