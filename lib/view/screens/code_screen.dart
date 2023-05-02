import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/view/screens/auth_screen.dart';
import 'package:jewelry/view/screens/main_screen.dart';
import 'package:jewelry/view/widgets/app_text_field.dart';

import '../widgets/app_button.dart';

class CodeScreen extends StatefulWidget {
  final String phone;

  const CodeScreen({
    super.key,
    required this.phone,
  });

  @override
  State<StatefulWidget> createState() => CodeScreenState();
}

class CodeScreenState extends State<CodeScreen> {
  String code1 = "";
  String code2 = "";
  String code3 = "";
  String code4 = "";

  int timer = 59;

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  Future<void> startTimer() async {
    Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        if (timer > 0) {
          timer--;
        } else {
          timer = 60;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AppTextButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (b) => const AuthScreen()));
                    },
                    label: "Назад",
                  ),
                )
              ],
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Введите код",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Код отправлен на ${widget.phone}.",
                        style: TextStyle(
                            fontSize: 14, color: Colors.black.withOpacity(0.5)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    child: AppTextField(
                      onChanged: (code) {
                        if (code.length <= 1) {
                          code1 = code;
                        }

                        if (code.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      maxLines: 1,
                      maxLength: 1,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 23,
                      ),
                      textAlign: TextAlign.center,
                      contentPadding: EdgeInsets.zero,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                      width: 48,
                      height: 48,
                      child: AppTextField(
                        onChanged: (code) {
                          if (code.length <= 1) {
                            code2 = code;
                          }

                          if (code.length == 1) {
                            FocusScope.of(context).nextFocus();
                          } else if (code.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        maxLines: 1,
                        maxLength: 1,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 23,
                        ),
                        textAlign: TextAlign.center,
                        contentPadding: EdgeInsets.zero,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                      )),
                  SizedBox(width: 8),
                  Container(
                      width: 48,
                      height: 48,
                      child: AppTextField(
                        onChanged: (code) {
                          if (code.length <= 1) {
                            code3 = code;
                          }

                          if (code.length == 1) {
                            FocusScope.of(context).nextFocus();
                          } else if (code.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        maxLines: 1,
                        maxLength: 1,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 23,
                        ),
                        textAlign: TextAlign.center,
                        contentPadding: EdgeInsets.zero,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                      )),
                  SizedBox(width: 8),
                  Container(
                    width: 48,
                    height: 48,
                    child: AppTextField(
                      onChanged: (code) {
                        if (code.length <= 1) {
                          code4 = code;
                        }

                        if (code.length == 1) {
                          Navigator.push(context, MaterialPageRoute(builder: (builder) => MainScreen()));
                          FocusScope.of(context).unfocus();
                        } else if (code.isEmpty) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                      maxLines: 1,
                      maxLength: 1,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 23,
                      ),
                      textAlign: TextAlign.center,
                      contentPadding: EdgeInsets.zero,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                width: 216,
                child: Text(
                  "Запросить новый код можно будет через $timer",
                  style: TextStyle(
                      fontSize: 14, color: Colors.black.withOpacity(0.5)),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
