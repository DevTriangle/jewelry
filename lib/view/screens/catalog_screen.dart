import 'package:flutter/material.dart';
import 'package:jewelry/view/widgets/app_text_field.dart';
import 'package:jewelry/view/widgets/category_chip.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/catalog_viewmodel.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<StatefulWidget> createState() => CatalogScreenState();
}

class CatalogScreenState extends State<CatalogScreen> {
  late CatalogViewModel viewModel;

  @override
  void initState() {
    super.initState();

    viewModel = Provider.of<CatalogViewModel>(context, listen: false);
  }

  String _searchText = "";

  String _selectedCategory = "Популярное";
  final List<String> _categoryList = [
    "Популярное",
    "Золото",
    "Серебро",
    "Платина",
    "Позолота"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            )),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categoryList.length,
                  itemBuilder: (builder, index) {
                    return CategoryChip(
                        label: _categoryList[index],
                        onTap: () {
                          setState(() {
                            _selectedCategory = _categoryList[index];
                          });
                        },
                        isSelected: _selectedCategory == _categoryList[index]);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
