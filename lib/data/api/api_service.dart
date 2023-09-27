import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/response/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/response/restaurant_search_response.dart';

import '../model/response/restaurant_response.dart';

class ApiService {
  final http.Client client;

  ApiService(this.client);

  static const String baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantResponse> getRestaurantList() async {
    final response = await client.get(Uri.parse('$baseUrl/list'));
    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await client.get(Uri.parse('$baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<RestaurantSearchResponse> getRestaurantSearch(String query) async {
    final response = await client.get(Uri.parse('$baseUrl/search?q=$query'));
    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurant');
    }
  }
}
