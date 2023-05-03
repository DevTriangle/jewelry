import 'package:flutter/material.dart';

import '../model/catalog_item.dart';

class CatalogViewModel extends ChangeNotifier {
  List<CatalogItem> catalog = [
    CatalogItem(
        id: 0,
        name: "Золотые серьги с бриллиантами",
        shortDesc: "shortDesc",
        description: "qwrqerqrwqrwqr",
        price: "93893",
        categories: ["Позолота"],
        brand: "brand",
        weight: 20,
        material: "Золото-платина",
        rating: 4,
        image:
            "https://g3.sunlight.net/media/products/59c472377e3f83847d2e3c8fd683a2add134430f.jpg"),
    CatalogItem(
        id: 1,
        name: "Золотое кольцо с бриллиантами",
        shortDesc: "shortDesc",
        description: "erwrewerwerwerwerwerwer",
        price: "141293",
        categories: ["Серебро"],
        brand: "brand",
        weight: 20,
        material: "Золото-платина",
        rating: 4,
        image:
            "https://g6.sunlight.net/media/products/d300420c272d14181c5a32b4a2e58018ed092246.jpg"),
    CatalogItem(
        id: 2,
        name: "name",
        shortDesc: "shortDesc",
        description: "wdwerewrerwerwerad",
        price: "135255",
        categories: ["Золото", "Платина"],
        brand: "brand",
        weight: 20,
        material: "Золото-платина",
        rating: 4,
        image:
            "https://g3.sunlight.net/media/products/59c472377e3f83847d2e3c8fd683a2add134430f.jpg"),
  ];
}