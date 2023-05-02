import 'dart:convert';

import 'package:jewelry/model/cart_item.dart';

import '../model/catalog_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  void saveCart(List<AppCartItem> cart) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    shared.setString("cart", jsonEncode(cart.map((e) => e.toJson()).toList()));
  }

  Future<List<AppCartItem>> getCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final js = sharedPreferences.getString("cart");

    Iterable list = json.decode(js!);

    List<AppCartItem> cart = List.from(list.map((e) => AppCartItem.fromJson(e)));

    return cart;
  }
}