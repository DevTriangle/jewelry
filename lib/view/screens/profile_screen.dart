import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/utils/data_saver.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/screens/auth_screen.dart';
import 'package:jewelry/view/widgets/app_button.dart';
import 'package:jewelry/view/widgets/app_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  String _phone = "";
  String _firstName = "";
  String _lastName = "";
  String _patronymic = "";

  late Future<bool> getData;

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _patronymicController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getData = loadData();
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
        _firstName = user.firstName;
        _firstNameController.text = _firstName;

        _lastName = user.lastName;
        _lastNameController.text = _lastName;

        _patronymic = user.patronymic;
        _patronymicController.text = _patronymic;
      }

      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Профиль",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FutureBuilder(
                future: getData,
                builder: (b, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text("Фамилия *",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.hintColor)),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            AppTextField(
                              onChanged: (text) {
                                setState(() {
                                  _lastName = text;
                                });
                              },
                              textEditingController: _lastNameController,
                            ),
                            const SizedBox(height: 4),
                            const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text("Имя *",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.hintColor)),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            AppTextField(
                              onChanged: (text) {
                                setState(() {
                                  _firstName = text;
                                });
                              },
                              textEditingController: _firstNameController,
                            ),
                            const SizedBox(height: 4),
                            const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text("Отчество",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.hintColor)),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            AppTextField(
                                onChanged: (text) {
                                  setState(() {
                                    _patronymic = text;
                                  });
                                },
                                textEditingController: _patronymicController),
                            const SizedBox(height: 4),
                            const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text("Телефон *",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.hintColor)),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            AppTextField(
                              onChanged: (text) {
                                setState(() {
                                  _phone = text;
                                });
                              },
                              hintText: "(900) 123 45 67",
                              prefixText: "+7 ",
                              maxLength: 10,
                              textEditingController: _phoneController,
                            ),
                            const SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(
                                    child: AppButton(
                                  label: "Сохранить",
                                  onTap: RegExp(r'^[0-9]{10}$').hasMatch(_phone) &&
                                          _firstName.trim().isNotEmpty &&
                                          _lastName.trim().isNotEmpty
                                      ? () {}
                                      : null,
                                  background: RegExp(r'^[0-9]{10}$').hasMatch(_phone) &&
                                          _firstName.trim().isNotEmpty &&
                                          _lastName.trim().isNotEmpty
                                      ? AppColors.primary
                                      : AppColors.primary.withOpacity(0.5),
                                )),
                              ],
                            )
                          ],
                        )
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
