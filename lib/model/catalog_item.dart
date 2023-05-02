import 'package:flutter/foundation.dart';

import 'category_item.dart';

class CatalogItem {
  final int id;
  final String name;
  final String shortDesc;
  final String description;
  final double price;
  final List<CategoryItem> categories;
  final String brand;
  final double weight;
  final String material;

  CatalogItem({
    required this.id,
    required this.name,
    required this.shortDesc,
    required this.description,
    required this.price,
    required this.categories,
    required this.brand,
    required this.weight,
    required this.material,
  });

  factory CatalogItem.fromJson(Map<String, dynamic> json) {
    return CatalogItem(id: json["id"],
        name: json["name"],
        shortDesc: json["shortDesc"],
        description: json["description"],
        price: json["price"],
        categories: json["categories"],
        brand: json["brand"],
        weight: json["weight"],
        material: json["material"],
    );
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "shortDesc": shortDesc,
    "description": description,
    "price": price,
    "categories": categories,
    "brand": brand,
    "weight": weight,
    'material': material,
  };
}