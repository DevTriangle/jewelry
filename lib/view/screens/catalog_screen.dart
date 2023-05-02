import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<StatefulWidget> createState() => CatalogScreenState();
}

class CatalogScreenState extends State<CatalogScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [

              ],
            ),
          ),
        ),
      ),
    );
  }
}
