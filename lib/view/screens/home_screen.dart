import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/model/catalog_item.dart';
import 'package:jewelry/view/screens/item_screen.dart';
import 'package:jewelry/view/shapes.dart';
import 'package:jewelry/view/widgets/app_item.dart';
import 'package:jewelry/viewmodel/catalog_viewmodel.dart';
import 'package:provider/provider.dart';
import '../widgets/chip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late CatalogViewModel viewModel;
  PageController _controller = PageController();

  @override
  void initState() {
    super.initState();

    viewModel = Provider.of<CatalogViewModel>(context, listen: false);

    startTimer();
  }

  String _selectedCategory = "Популярное";
  final List<String> _categoryList = [
    "Популярное",
    "Золото",
    "Серебро",
    "Платина",
    "Позолота"
  ];

  Future<void> startTimer() async {
    Timer.periodic(const Duration(seconds: 3), (t) {
        if (_controller.page != null) {
          if (_controller.page! < 1) {
            _controller.animateToPage(_controller.page!.toInt() + 1,
                duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          } else {
            _controller.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          }
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: PageView.builder(
                        itemCount: 2,
                        controller: _controller,
                        itemBuilder: (itemBuilder, index) {
                          return Card(
                            elevation: 0,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            shape: AppShapes.roundedRectangleShape,
                            clipBehavior: Clip.antiAlias,
                            color: Colors.transparent,
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Aspect_ratio_-_16x9.svg/2560px-Aspect_ratio_-_16x9.svg.png",
                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        const Text(
                          "Каталог",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 50,
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
                                  isSelected: _selectedCategory ==
                                      _categoryList[index]);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
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
                                        element.categories
                                            .contains(_selectedCategory) ||
                                        _selectedCategory == "Популярное")
                                    .length, (index) {
                              List<CatalogItem> catalogFiltered = List.from(
                                  viewModel.catalog.where((element) =>
                                      element.categories
                                          .contains(_selectedCategory) ||
                                      _selectedCategory == "Популярное"));
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
                                                    id: catalogFiltered[index]
                                                        .id,
                                                    name: catalogFiltered[index]
                                                        .name,
                                                    shortDesc:
                                                        catalogFiltered[index]
                                                            .shortDesc,
                                                    description:
                                                        catalogFiltered[index]
                                                            .description,
                                                    price: catalogFiltered[index]
                                                        .price,
                                                    categories:
                                                        catalogFiltered[index]
                                                            .categories,
                                                    sizeList:
                                                        catalogFiltered[index]
                                                            .sizeList,
                                                    brand: catalogFiltered[index]
                                                        .brand,
                                                    weight: catalogFiltered[index]
                                                        .weight,
                                                    rating: catalogFiltered[index]
                                                        .rating,
                                                    material: catalogFiltered[index].material,
                                                    image: catalogFiltered[index].image))));
                                  });
                            })),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
