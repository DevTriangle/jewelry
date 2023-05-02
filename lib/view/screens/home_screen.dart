import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/model/catalog_item.dart';
import 'package:jewelry/view/screens/item_screen.dart';
import 'package:jewelry/view/shapes.dart';
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
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16/9,
                    child: PageView.builder(
                        itemCount: 2,
                        itemBuilder: (itemBuilder, index) {
                          return Card(
                            elevation: 0,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            shape: AppShapes.roundedRectangleShape,
                            clipBehavior: Clip.antiAlias,
                            color: Colors.transparent,
                            child: CachedNetworkImage(
                                imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Aspect_ratio_-_16x9.svg/2560px-Aspect_ratio_-_16x9.svg.png",
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                      "Популярные товары",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 16),
                  GridView.extent(
                      maxCrossAxisExtent: 200,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.8,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(100, (index) {
                          return AppItem(
                              label: "Браслет золотой",
                              description: "Золото 100 грамм 999 пробы",
                              imageUrl: "https://www.gold-fenix.ru/upload/iblock/8d4/c1nkn79xawyfh8q06ao33xnfe45dunhd.jpg",
                              cost: "70000",
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (builder) => ItemScreen(item: CatalogItem(id: 0, name: "name", shortDesc: "shortDesc", description: "description", price: "70000", categories: ["name", "name2"], brand: "brand", weight: 10, rating: 5.0, material: "material", image: "https://www.gold-fenix.ru/upload/iblock/8d4/c1nkn79xawyfh8q06ao33xnfe45dunhd.jpg"))));
                              }
                          );
                        })
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
