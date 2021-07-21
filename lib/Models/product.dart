class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.content,
    required this.location,
    required this.preview,
  });

  int id;
  String name;
  String price;
  String content;
  String location;
  String preview;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        content: json["content"],
        location: json["location"],
        preview: json["preview"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "content": content,
        "location": location,
        "preview": preview,
      };
}
