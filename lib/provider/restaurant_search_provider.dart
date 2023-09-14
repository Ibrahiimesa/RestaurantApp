import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/response/restaurant_search_response.dart';

import '../data/api/api_service.dart';
import '../utils/result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  late RestaurantSearchResponse _restaurantSearchResult;
  ResultState? _state;
  String _message = '';

  RestaurantSearchResponse get result => _restaurantSearchResult;

  ResultState? get state => _state;

  String get message => _message;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getRestaurantSearch(query);
      if (response.founded == 0) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Not Found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearchResult = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
