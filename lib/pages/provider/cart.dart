import 'package:flutter/cupertino.dart';
import 'package:restaurant/pages/provider/item.dart';

class Cart with ChangeNotifier {
  List<Item> items = [];

  int price = 0;

  void add_cart(Item item) {
    items.add(item);
    price = price + item.ite_price;
    notifyListeners();
  }

  void remove_cart(Item item) {
    items.remove(item);
    price = price - item.ite_price;
    notifyListeners();
  }

  int getCountItems() {
    return items.length;
  }

  int getCountByItem(Item item) {
    int count = 0;
    for (int i = 0; i < items.length; i++) {
      if (items[i].ite_id == item.ite_id) {
        count++;
      }
    }
    return count;
  }

  int getPrice() {
    return price;
  }
}
