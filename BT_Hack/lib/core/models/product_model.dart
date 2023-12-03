import 'dart:convert';


class Product {


  Product({
    required this.image,
    required this.title,
    required this.id,
    required this.price,
    required this.description,
    required this.category,
    required this.rating,
  });

  String image = "";
  String title = "";
  String category = "";
  double price;
  String description="";
  int id;
  Rating rating = Rating(rate: 0.0, count: 0);



  factory Product.fromJson(Map<String,dynamic> json)=>Product(
      title: json["title"] ?? "no title",
      id: json["id"] ?? 0,
      image: json["image"] ?? "no image",
      category: json["category"] ?? "no category",
      price: json['price'].toDouble(),
      rating: Rating.fromJson(json["rating"]),
      description: json["description"] ?? "no description",
  );
}

class Rating {
  Rating({
    required this.rate,
    required this.count,
  });

  double rate = 0.0;
  int count = 0;

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json["rate"].toDouble() ?? 0.0,
      count: json["count"] ?? 0,
    );
  }
}