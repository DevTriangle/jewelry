import 'package:flutter/material.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/widgets/app_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
                    onTap: () {},
                    label: "Пропустить",
                  ),
                )
              ],
            ),
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.auth_title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    AppLocalizations.of(context)!.auth_desc,
                    style: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.5)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
