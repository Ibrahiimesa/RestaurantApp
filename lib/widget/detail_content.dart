import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/widget/card_menu.dart';

import '../data/model/restaurant_model.dart';
import '../ui/favorite_screen.dart';

class DetailContent extends StatelessWidget {
  final RestaurantDetail restaurant;
  final RestaurantDetailProvider provider;

  const DetailContent(
      {super.key, required this.restaurant, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (_, favoriteProvider, __) {
      return FutureBuilder(
          future: favoriteProvider.isFavorite(restaurant.id),
          builder: (_, snapshot) {
            final isFavorite = snapshot.data ?? false;

            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            size: 18,
                            color: Colors.blueGrey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            restaurant.city,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.star,
                            size: 18,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            restaurant.rating.toString(),
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.black26, thickness: 2),
                      Text(
                        restaurant.description,
                        textAlign: TextAlign.justify,
                      ),
                      const Divider(color: Colors.black26, thickness: 2),
                      const Text(
                        "Menu",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                          children: restaurant.menus.foods.map<Widget>((foods) {
                            return MenuCard(
                              icon: Icons.fastfood,
                              menu: foods.name,
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                          children:
                              restaurant.menus.drinks.map<Widget>((drinks) {
                            return MenuCard(
                              icon: Icons.fastfood,
                              menu: drinks.name,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 16,
                  child: isFavorite
                      ? FloatingActionButton(
                          onPressed: () {
                            favoriteProvider.removeFavorite(restaurant.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                content: const Text(
                                  'Remove From Favorite',
                                ),
                                action: SnackBarAction(
                                  label: 'View',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RestaurantFavorite.routeName);
                                  },
                                ),
                              ),
                            );
                          },
                          mini: true,
                          child: const Icon(
                            Icons.favorite,
                            size: 28,
                          ),
                        )
                      : FloatingActionButton(
                          onPressed: () {
                            favoriteProvider.addFavorite(
                              Restaurant(
                                id: restaurant.id,
                                name: restaurant.name,
                                description: restaurant.description,
                                city: restaurant.city,
                                pictureId: restaurant.pictureId,
                                rating: restaurant.rating,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                content: const Text(
                                  'Add To Favorite',
                                ),
                                action: SnackBarAction(
                                  label: 'View',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RestaurantFavorite.routeName);
                                  },
                                ),
                              ),
                            );
                          },
                          mini: true,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 28,
                          ),
                        ),
                ),
              ],
            );
          });
    });
  }
}
