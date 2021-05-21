import 'dart:collection';

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

  List<Item> listItems() {
    List<Item> newItems = new List<Item>();
    items.forEach((item) {
      var contain = newItems.where((element) => element.ite_id == item.ite_id);
      if (contain.isEmpty) {
        newItems.add(item);
      } else {
        print("exists");
      }
    });
    // List<Item> result = LinkedHashSet<Item>.from(items).toList();
    return newItems;
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
