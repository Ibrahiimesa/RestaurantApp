import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/search_screen.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';

import '../data/api/api_service.dart';

class RestaurantList extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildList(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Restaurant App'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.pushNamed(context, RestaurantSearch.routeName);
          },
        ),
      ],
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (_, provider, __) {
        switch (provider.state) {
          case ResultState.loading:
            return Center(
              child: Lottie.asset('assets/loading.json',
                  height: 160, width: 100, repeat: true),
            );
          case ResultState.hasData:
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              shrinkWrap: true,
              itemCount: provider.result.count,
              itemBuilder: (_, index) {
                final restaurant = provider.result.restaurants[index];
                return RestaurantCard(restaurant: restaurant);
              },
            );
          case ResultState.noData:
            return Center(
              child: Lottie.asset('assets/not_found.json',
                  height: 400, width: 200),
            );
          case ResultState.error:
            return Center(
              child: Lottie.asset('assets/error.json', height: 400, width: 200),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
