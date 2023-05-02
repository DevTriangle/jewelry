import 'package:flutter/material.dart';
import 'package:jewelry/view/widgets/AppButton.dart';

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
                AppTextButton(
                    onTap: () {},
                    label: "Пропустить",
                )
              ],
            ),
          ),
          body: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}