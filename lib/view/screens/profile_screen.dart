import 'package:flutter/material.dart';
import 'package:jewelry/utils/data_saver.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/screens/auth_screen.dart';
import 'package:jewelry/view/widgets/app_button.dart';
import 'package:jewelry/view/widgets/app_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user.dart';
import '../shapes.dart';
import '../widgets/app_snackbar_content.dart';

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

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _patronymicController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getData = loadData();
  }

  Future<bool> loadData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? phone = sharedPreferences.getString("phone");

    if (phone == null) {
      Navigator.push(context, MaterialPageRoute(builder: (builder) => const AuthScreen()));
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
                            Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: RichText(
                                  text: const TextSpan(children: [
                                TextSpan(
                                    text: "Фамилия ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.hintColor)),
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.red))
                              ])),
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
                            Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: RichText(
                                  text: const TextSpan(children: [
                                TextSpan(
                                    text: "Имя ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.hintColor)),
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.red))
                              ])),
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
                            Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: RichText(
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
                                  onTap: RegExp(r'^[0-9]{10}$')
                                              .hasMatch(_phone) &&
                                          _firstName.trim().isNotEmpty &&
                                          _lastName.trim().isNotEmpty
                                      ? () async {
                                          await DataSaver().saveUserData(User(
                                              firstName: _firstName,
                                              lastName: _lastName,
                                              patronymic: _patronymic,
                                              phone: _phone));

                                          final snackBar = SnackBar(
                                              shape: AppShapes.roundedRectangleShape,
                                              margin: const EdgeInsets.all(10),
                                              padding: const EdgeInsets.symmetric(     horizontal: 10,     vertical: 15),
                                              behavior:SnackBarBehavior.floating,
                                              content: const AppSnackBarContent(label: "Изменения сохранены!",icon: Icons.save_rounded));
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        }
                                      : null,
                                  background:
                                      RegExp(r'^[0-9]{10}$').hasMatch(_phone) &&
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