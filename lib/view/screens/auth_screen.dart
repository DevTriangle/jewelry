import 'package:flutter/material.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/screens/code_screen.dart';
import 'package:jewelry/view/screens/main_screen.dart';
import 'package:jewelry/view/widgets/app_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jewelry/view/widgets/app_text_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  String _phone = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AppTextButton(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (builder) => MainScreen()));
                    },
                    label: "Пропустить",
                  ),
                )
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.auth_title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  AppLocalizations.of(context)!.auth_desc,
                  style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                AppTextField(
                    onChanged: (text) {
                      _phone = text;
                    },
                  prefixText: "+7",
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (b) => CodeScreen(phone: "+7 $_phone",)));
                        },
                        label: "Получить код",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "Нажимая на кнопку выше, вы соглашаетесь с условиями использования и политикой конфиденциальности.",
                  style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5))
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
