import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jewelry/model/cart_item.dart';
import 'package:jewelry/model/payment_method.dart';
import 'package:jewelry/utils/format_count.dart';
import 'package:jewelry/view/widgets/cart_item.dart';
import 'package:jewelry/view/widgets/payment_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user.dart';
import '../../utils/data_saver.dart';
import '../colors.dart';
import '../widgets/app_text_field.dart';
import 'auth_screen.dart';

class OrderScreen extends StatefulWidget {
  final List<AppCartItem> cart;

  const OrderScreen({super.key, required this.cart});

  @override
  State<StatefulWidget> createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  String _name = "";
  String _mail = "";
  String _phone = "";
  String _promo = "";
  String _address = "";

  final List<String> _addressList = [
    "Улица 1, д.1",
    "Улица 2, д.2",
    "Улица 3, д.3",
    "Улица 4, д.4",
    "Улица 5, д.5",
    "Улица 6, д.6",
    "Улица 7, д.7"
  ];

  int _selectedPaymentMethod = -1;
  int sum = 0;
  int count = 0;

  late Future<bool> getData;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final List<PaymentMethod> _methods = [
    PaymentMethod("Оплата картой/наличными при получении", Icons.money_rounded),
    PaymentMethod("Оплата картой онлайн", Icons.payment_rounded),
  ];

  @override
  void initState() {
    super.initState();

    getData = loadData();

    for (var c in widget.cart) {
      sum += c.count * int.parse(c.price);
      count += c.count;
    }
  }

  Future<bool> loadData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? phone = sharedPreferences.getString("phone");

    if (phone == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => const AuthScreen()));
      return false;
    } else {
      _phone = phone.replaceAll("+7 ", "");
      _phoneController.text = _phone;

      User? user = await DataSaver().loadUserData();

      if (user != null) {
        _name = user.firstName + " " + user.lastName;
        _nameController.text = _name;
      }

      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: _name.trim().isNotEmpty &&
                            _phone.trim().isNotEmpty &&
                            _mail.trim().isNotEmpty &&
                            _selectedPaymentMethod != -1 &&
                            _address != ""
                        ? AppColors.primary : const Color.fromARGB(255, 183, 183, 183),
        statusBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              height: 50,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        elevation: 0,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        "Оформление заказа",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            ),
          ),
          body: Stack(children: [
            Positioned.fill(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: FutureBuilder(
                    future: getData,
                    builder: (b, snaspshot) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text(
                                "Информация о покупателе",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              RichText(
                                  text: const TextSpan(children: [
                                TextSpan(
                                    text: "Имя и фамилия",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.hintColor)),
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.red))
                              ])),
                              const SizedBox(
                                height: 2,
                              ),
                              AppTextField(
                                onChanged: (text) {
                                  setState(() {
                                    _name = text;
                                  });
                                },
                                textEditingController: _nameController,
                              ),
                              SizedBox(height: 8),
                              RichText(
                                  text: const TextSpan(children: [
                                TextSpan(
                                    text: "Телефон ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.hintColor)),
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.red))
                              ])),
                              const SizedBox(
                                height: 2,
                              ),
                              AppTextField(
                                onChanged: (text) {
                                  setState(() {
                                    _phone = text;
                                  });
                                },
                                textEditingController: _phoneController,
                              ),
                              SizedBox(height: 8),
                              RichText(
                                  text: const TextSpan(children: [
                                TextSpan(
                                    text: "Эл. почта",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.hintColor)),
                                TextSpan(
                                    text: " *",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.red))
                              ])),
                              const SizedBox(
                                height: 2,
                              ),
                              AppTextField(
                                onChanged: (text) {
                                  setState(() {
                                    _mail = text;
                                  });
                                },
                              ),
                              SizedBox(height: 16),
                              const Text(
                                "Способ оплаты",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 8),
                              AppTextField(
                                onChanged: (text) {},
                                textEditingController: _addressController,
                                readOnly: true,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      dropdownColor: Colors.white,
                                      icon: Icon(Icons.arrow_drop_down_rounded,
                                          color: AppColors.iconColor),
                                      onChanged: (item) {
                                        setState(() {
                                          _address = item.toString();

                                          _addressController.text =
                                              item.toString();
                                        });
                                      },
                                      items: _addressList.map((String i) {
                                        return DropdownMenuItem<String>(
                                            value: i,
                                            child: Text(
                                              i,
                                              style: TextStyle(fontSize: 14),
                                            ));
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              const Text(
                                "Способ оплаты",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 8),
                              ListView.builder(
                                itemCount: 2,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return PaymentCard(
                                      label: _methods[index].name,
                                      icon: _methods[index].icon,
                                      isSelected:
                                          _selectedPaymentMethod == index,
                                      onClick: () {
                                        setState(() {
                                          _selectedPaymentMethod = index;
                                        });
                                      });
                                },
                              ),
                              SizedBox(height: 16),
                              // AppTextField(
                              //   onChanged: (text) {
                              //     setState(() {
                              //       _promo = text;
                              //     });
                              //   },
                              //   hintText: "Промокод",
                              // ),
                              // SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Итого",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18)),
                                  Column(
                                    children: [
                                      Text("$sum ₽",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18)),
                                      Text(
                                          "$count ${getPluralForm(count, "изделие", "изделия", "изделий")}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: AppColors.hintColor)),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 90),
                            ]),
                      );
                    }),
              ),
            ),
            PositionedDirectional(
                bottom: 0,
                start: 0,
                end: 0,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: _name.trim().isNotEmpty &&
                          _phone.trim().isNotEmpty &&
                          _mail.trim().isNotEmpty &&
                          _selectedPaymentMethod != -1 &&
                          _address != ""
                      ? AppColors.primary
                      : Color.fromARGB(255, 183, 183, 183),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  child: InkWell(
                    onTap: _name.trim().isNotEmpty &&
                            _phone.trim().isNotEmpty &&
                            _mail.trim().isNotEmpty &&
                            _selectedPaymentMethod != -1 &&
                            _address != ""
                        ? () {}
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Оплатить",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            "$sum ₽",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.7)),
                          )
                        ],
                      ),
                    ),
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
