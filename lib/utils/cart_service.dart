import 'dart:convert';

import '../model/catalog_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  void saveCart(List<CatalogItem> cart) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    shared.setString("cart", jsonEncode(cart.map((e) => e.toJson()).toList()));
  }

  Future<List<CatalogItem>> getCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final js = sharedPreferences.getString("cart");

    Iterable list = json.decode(js!);

    List<CatalogItem> cart = List.from(list.map((e) => CatalogItem.fromJson(e)));

    return cart;
  }
}