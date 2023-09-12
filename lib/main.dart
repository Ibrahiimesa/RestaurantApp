import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/detail_screen.dart';
import 'package:restaurant_app/ui/home_screen.dart';
import 'package:restaurant_app/ui/search_screen.dart';

import 'data/model/restaurant_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RestaurantList.routeName,
      routes: {
        RestaurantList.routeName: (context) => const RestaurantList(),
        RestaurantSearch.routeName: (context) => const RestaurantSearch(),
        RestaurantDetail.routeName: (context) => RestaurantDetail(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
