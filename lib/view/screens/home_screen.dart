import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/view/widgets/app_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                AppItem(
                    imageUrl: "imageUrl",
                    cost: "70000",
                    onTap: () {

                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
