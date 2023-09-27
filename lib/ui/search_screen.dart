import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';

import '../utils/result_state.dart';
import '../widget/card_restaurant.dart';

class RestaurantSearch extends StatelessWidget {
  static const routeName = '/restaurant_search';

  const RestaurantSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          RestaurantSearchProvider(apiService: ApiService(http.Client())),
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search Restaurant'),
          ),
          body: Column(
            children: [
              const SizedBox(height: 16),
              Card(
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                color: Colors.white,
                child: TextField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                    hintText: 'Search restaurant',
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  onSubmitted: (query) {
                    if (query != '') {
                      Provider.of<RestaurantSearchProvider>(
                        context,
                        listen: false,
                      ).fetchSearchRestaurant(query);
                    }
                  },
                ),
              ),
              Expanded(
                child: Consumer<RestaurantSearchProvider>(
                  builder: (_, provider, __) {
                    switch (provider.state) {
                      case ResultState.loading:
                        return Center(
                          child: Lottie.asset('assets/loading.json',
                              height: 160, width: 100),
                        );
                      case ResultState.hasData:
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          itemCount: provider.result.restaurants.length,
                          itemBuilder: (_, index) {
                            final restaurant =
                                provider.result.restaurants[index];
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
                          child: Lottie.asset('assets/error.json',
                              height: 400, width: 200),
                        );
                      default:
                        return Center(
                          child: Lottie.asset('assets/searching.json',
                              height: 200, width: 200, repeat: true),
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
