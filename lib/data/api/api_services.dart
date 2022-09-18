import 'dart:convert';
import 'dart:io';

import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/models/restaurant_detail_data.dart';
import 'package:restaurant_app/data/models/restaurant_search_data.dart';

import '../exception.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _restoList = 'list';
  static const String _restoDetail = 'detail/';

  Future<RestaurantModel> restoList() async {
    final response =
        await http.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));
    try {
      return RestaurantModel.fromJson(json.decode(response.body));
    } on SocketException {
      throw NoInternetException('No Internet');
    } on HttpException {
      throw NoServiceException('No Service Found');
    } catch (e) {
      throw UnknownException('Unknown Exception');
    }
  }

  Future<RestaurantModelDetail> restoDetail(String id) async {
    final response = await http
        .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id'));
    if (response.statusCode == 200) {
      return RestaurantModelDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantModelSearch> restoSearch(String query) async {
    final response = await http
        .get(Uri.parse('https://restaurant-api.dicoding.dev/search?q=$query'));
    if (response.statusCode == 200) {
      return RestaurantModelSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}