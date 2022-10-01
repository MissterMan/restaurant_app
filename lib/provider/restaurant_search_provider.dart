import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/models/restaurant_search_data.dart';

import '../data/models/restaurant.dart';
import '../util/result_state.dart';

class RestoSearchProvider extends ChangeNotifier {
  late final ApiService apiService;
  final String query;

  RestoSearchProvider({required this.apiService, required this.query}) {
    _fetchSearchResto();
  }

  late RestaurantModelSearch _restaurantModelSearch;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantModelSearch get result => _restaurantModelSearch;

  ResultState get state => _state;

  Future<dynamic> _fetchSearchResto() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantSearchResult = await apiService.restoSearch(query);
      if (restaurantSearchResult.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Restaurant Found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantModelSearch = restaurantSearchResult;
      }
    } on SocketException catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No internet connection';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error HALOO --> $e';
    }
  }
}
