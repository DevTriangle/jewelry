import 'package:flutter/material.dart';
import 'package:jewelry/view/widgets/app_text_field.dart';
import 'package:jewelry/view/widgets/chip.dart';
import 'package:provider/provider.dart';

import '../../model/catalog_item.dart';
import '../../viewmodel/catalog_viewmodel.dart';
import '../widgets/app_item.dart';
import 'item_screen.dart';

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
            preferredSize: const Size.fromHeight(122),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                  children: [
                    AppTextField(
                        hintText: "Поиск товаров",
                        onChanged: (text) {
                          _searchText = text;

                          setState(() {});
                        },
                    ),
                    Container(
                      height: 58,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categoryList.length,
                        itemBuilder: (builder, index) {
                          return AppChip(
                              label: _categoryList[index],
                              onTap: () {
                                setState(() {
                                  _selectedCategory = _categoryList[index];
                                });
                              },
                              isSelected: _selectedCategory == _categoryList[index]);
                        },
                      ),
                    ),
                  ],
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GridView.extent(
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.8,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(viewModel.catalog.where((element) => (element.categories.contains(_selectedCategory) || _selectedCategory == "Популярное") && element.name.toLowerCase().contains(_searchText.toLowerCase())).length, (index) {
                      List<CatalogItem> catalogFiltered = List.from(viewModel.catalog.where((element) => (element.categories.contains(_selectedCategory) || _selectedCategory == "Популярное") && element.name.toLowerCase().contains(_searchText.toLowerCase())));

                      return AppItem(
                          label: catalogFiltered[index].name,
                          description: catalogFiltered[index].shortDesc,
                          imageUrl: catalogFiltered[index].image,
                          cost: catalogFiltered[index].price,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => ItemScreen(
                                        item: CatalogItem(
                                            id: catalogFiltered[index].id,
                                            name: catalogFiltered[index].name,
                                            shortDesc: catalogFiltered[index].shortDesc,
                                            description: catalogFiltered[index].description,
                                            price: catalogFiltered[index].price,
                                            categories: catalogFiltered[index].categories,
                                            sizeList: catalogFiltered[index].sizeList,
                                            brand: catalogFiltered[index].brand,
                                            weight: catalogFiltered[index].weight,
                                            rating: catalogFiltered[index].rating,
                                            material: catalogFiltered[index].material,
                                            image: catalogFiltered[index].image))));
                          });
                    })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
