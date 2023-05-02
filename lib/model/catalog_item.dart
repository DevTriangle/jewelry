import 'package:flutter/foundation.dart';

class CatalogItem {
  final int id;
  final String name;
  final String shortDesc;
  final String description;
  final String price;
  final List<String> categories;
  final String brand;
  final double weight;
  final String material;
  final double rating;
  final String image;

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
    required this.rating,
    required this.image,
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
        rating: json["rating"],
        material: json["material"],
        image: json["image"],
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
    "rating": rating,
    'material': material,
    'image': image,
  };
}