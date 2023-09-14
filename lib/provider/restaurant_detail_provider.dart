import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/response/restaurant_detail_response.dart';

import '../data/api/api_service.dart';
import '../utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchRestaurantDetail(id);
  }

  late RestaurantDetailResponse _restaurantDetailResult;
  late ResultState _state;
  String _message = '';

  RestaurantDetailResponse get result => _restaurantDetailResult;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> _fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getRestaurantDetail(id);
      if (!response.error) {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailResult = response;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "No data found";
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
