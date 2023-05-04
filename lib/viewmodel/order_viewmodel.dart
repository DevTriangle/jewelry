import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/payment_method.dart';

class OrderViewModel extends ChangeNotifier {
  final List<PaymentMethod> methods = [
    PaymentMethod("Оплата картой/наличными при получении", Icons.money_rounded),
    PaymentMethod("Оплата картой онлайн", Icons.payment_rounded),
  ];

  final List<String> addressList = [
    "Улица 1, д.1",
    "Улица 2, д.2",
    "Улица 3, д.3",
    "Улица 4, д.4",
    "Улица 5, д.5",
    "Улица 6, д.6",
    "Улица 7, д.7"
  ];
}