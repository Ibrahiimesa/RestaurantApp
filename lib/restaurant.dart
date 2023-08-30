import 'dart:convert';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) => Restaurant(
        id: restaurant['id'],
        name: restaurant['name'],
        description: restaurant['description'],
        pictureId: restaurant['pictureId'],
        city: restaurant['city'],
        rating: restaurant['rating'].toDouble(),
        menus: Menus.fromJson(restaurant['menus']),
      );
}

class Menus {
  List<Foods> foods;
  List<Drinks> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Foods>.from(json["foods"].map((x) => Foods.fromJson(x))),
        drinks:
            List<Drinks>.from(json["drinks"].map((x) => Drinks.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class Foods {
  final String name;

  Foods({
    required this.name,
  });

  factory Foods.fromJson(Map<String, dynamic> json) => Foods(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Drinks {
  final String name;

  Drinks({
    required this.name,
  });

  factory Drinks.fromJson(Map<String, dynamic> json) => Drinks(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

List<Restaurant> parseArticles(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
