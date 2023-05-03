class AppCartItem {
  final int id;
  final String name;
  final String description;
  final String size;
  int count;
  final String price;
  final String image;

  AppCartItem({
    required this.id,
    required this.name,
    required this.description,
    required this.size,
    required this.count,
    required this.price,
    required this.image
  });

  factory AppCartItem.fromJson(Map<String, dynamic> json) {
    return AppCartItem(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        size: json["size"],
        price: json["price"],
        image: json["image"],
        count: json["count"],
    );
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "size": size,
    "count": count,
    "price": price,
    "image": image
  };
}
