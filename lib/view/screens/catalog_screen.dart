import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/view/widgets/app_text_field.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<StatefulWidget> createState() => CatalogScreenState();
}

class CatalogScreenState extends State<CatalogScreen> {
  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(86),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AppTextField(
                hintText: "Поиск товаров",
                onChanged: (text) {
                  _searchText = text;
                },
              ),
            )
          ),
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
