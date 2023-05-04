import 'package:flutter/material.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/widgets/app_button.dart';
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

  final TextEditingController _brandEditingController = TextEditingController();
  final TextEditingController _materialEditingController = TextEditingController();

  final List<String> _brandList = [
    "Любой",
    "Компания",
    "Компания 1",
    "Компания 2",
    "Компания 3",
    "Компания 4",
    "brand",
  ];

  final List<String> _sizeList = [
    "Любой",
    "9",
    "10",
    "11",
    "12",
    "13.5",
    "14",
    "15.5",
    "16",
    "17",
    "18"
  ];

  final List<String> _materialList = [
    "Любой",
    "Золото",
    "Серебро",
    "Платина",
    "Бронза",
    "Медь",
    "Позолота"
  ];

  String _searchText = "";

  String _filterBrand = "Любой";
  String _filterSize = "Любой";
  String _filterMaterial = "Любой";

  @override
  void initState() {
    super.initState();

    viewModel = Provider.of<CatalogViewModel>(context, listen: false);

    _brandEditingController.text = _filterBrand;
    _materialEditingController.text = _filterMaterial;
  }

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
          preferredSize: Size.fromHeight(122),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              children: [
                Row(children: [
                  Expanded(
                    child: AppTextField(
                      hintText: "Поиск товаров",
                      onChanged: (text) {
                        _searchText = text;

                        setState(() {});
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        backgroundColor: Colors.white,
                        builder: (builder) {
                          return StatefulBuilder(
                              builder: (builder, setModalState) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Фильтры",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                            ),
                                            AppTextButton(
                                                onTap: () {
                                                  setModalState(() {
                                                    _filterSize = "Любой";
                                                    _filterBrand = "Любой";
                                                    _filterMaterial = "Любой";
                                                  });

                                                  setState(() {});
                                                },
                                                label: "Сбросить"
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          "Размер",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                        ),
                                        Container(
                                          height: 58,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _sizeList.length,
                                            itemBuilder: (builder, index) {
                                              return AppChip(
                                                  label: _sizeList[index],
                                                  onTap: () {
                                                    setModalState(() {
                                                      _filterSize =
                                                          _sizeList[index];
                                                    });

                                                    setState(() {});
                                                  },
                                                  isSelected: _filterSize ==
                                                      _sizeList[index]);
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Бренд",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                        ),
                                        SizedBox(height: 4),
                                        AppTextField(
                                          onChanged: (text) {},
                                          textEditingController: _brandEditingController,
                                          readOnly: true,
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 14),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                dropdownColor: Colors.white,
                                                icon: Icon(Icons.arrow_drop_down_rounded, color: AppColors.iconColor),
                                                onChanged: (item) {
                                                  setModalState(() {
                                                    _filterBrand = item.toString();

                                                    _brandEditingController.text = item.toString();
                                                  });

                                                  setState(() {});
                                                },
                                                items: _brandList.map((String i) {
                                                  return DropdownMenuItem<String>(
                                                    value: i,
                                                      child: Text(
                                                        i,
                                                        style: TextStyle(
                                                          fontSize: 14
                                                        ),
                                                      )
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Материал",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                        ),
                                        SizedBox(height: 4),
                                        AppTextField(
                                          onChanged: (text) {},
                                          textEditingController: _materialEditingController,
                                          readOnly: true,
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 14),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                dropdownColor: Colors.white,
                                                icon: Icon(Icons.arrow_drop_down_rounded, color: AppColors.iconColor),
                                                onChanged: (item) {
                                                  setModalState(() {
                                                    _filterMaterial = item.toString();

                                                    _materialEditingController.text = item.toString();
                                                  });

                                                  setState(() {});
                                                },
                                                items: _materialList.map((String i) {
                                                  return DropdownMenuItem<String>(
                                                      value: i,
                                                      child: Text(
                                                        i,
                                                        style: TextStyle(
                                                            fontSize: 14
                                                        ),
                                                      )
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: AppButton(
                                                label: "Применить",
                                                onTap: () {
                                                  Navigator.pop(context);

                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                        },
                      );
                    },
                    icon: Icon(
                      Icons.filter_alt_rounded,
                      color: AppColors.iconColor,
                    ),
                  ),
                ]),
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
                          isSelected:
                              _selectedCategory == _categoryList[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
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
                  children: List.generate(
                    viewModel.catalog
                        .where((element) =>
                            (element.categories.contains(_selectedCategory) ||
                                _selectedCategory == "Популярное") &&
                            element.name
                                .toLowerCase()
                                .contains(_searchText.toLowerCase()) &&
                            (element.sizeList.contains(_filterSize) || _filterSize == "Любой")
                                && (element.brand == _filterBrand || _filterBrand == "Любой")
                                && (element.material == _filterMaterial || _filterMaterial == "Любой")
                    )
                        .length,
                    (index) {
                      List<CatalogItem> catalogFiltered = List.from(
                          viewModel.catalog.where((element) =>
                              (element.categories.contains(_selectedCategory) ||
                                  _selectedCategory == "Популярное") &&
                                  (element.sizeList.contains(_filterSize) || _filterSize == "Любой")
                              && (element.brand == _filterBrand || _filterBrand == "Любой")
                              && (element.material == _filterMaterial || _filterMaterial == "Любой")));

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
                                    description:
                                        catalogFiltered[index].description,
                                    price: catalogFiltered[index].price,
                                    categories:
                                        catalogFiltered[index].categories,
                                    sizeList: catalogFiltered[index].sizeList,
                                    brand: catalogFiltered[index].brand,
                                    weight: catalogFiltered[index].weight,
                                    rating: catalogFiltered[index].rating,
                                    material: catalogFiltered[index].material,
                                    image: catalogFiltered[index].image),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
