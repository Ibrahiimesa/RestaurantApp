import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/detail_content.dart';

import '../data/api/api_service.dart';
import '../data/model/restaurant_model.dart';

class RestaurantDetail extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetail({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) =>
          RestaurantDetailProvider(apiService: ApiService(), id: restaurant.id),
      child: _buildContext(context),
    );
  }

  Widget _buildContext(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Image.network(
                  restaurant.largePictureUrl,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black26,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Consumer<RestaurantDetailProvider>(
              builder: (_, provider, __) {
                switch (provider.state) {
                  case ResultState.loading:
                    return Center(
                      child: Lottie.asset('assets/loading.json',
                          height: 160, width: 100),
                    );
                  case ResultState.hasData:
                    return DetailContent(
                      provider: provider,
                      restaurant: provider.result.restaurant,
                    );
                  case ResultState.error:
                    return Center(
                      child: Lottie.asset('assets/error.json',
                          height: 400, width: 200),
                    );
                  default:
                    return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
