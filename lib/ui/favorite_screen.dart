import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';

import '../provider/database_provider.dart';
import '../utils/result_state.dart';

class RestaurantFavorite extends StatelessWidget {
  static const routeName = '/restaurant_favorite';

  const RestaurantFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildList(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Favorite'),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return RestaurantCard(restaurant: provider.favorites[index]);
            },
          );
        } else {
          return Center(
            child: Material(
              child: Text(provider.message),
            ),
          );
        }
      },
    );
  }
}
