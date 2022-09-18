import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

import '../data/api/api_services.dart';

enum ResultState { loading, noData, hasData, error }

class RestoProvider extends ChangeNotifier {
  late final ApiService apiService;

  RestoProvider({required this.apiService}) {
    _fetchRestoList();
  }

  late RestaurantModel _restaurantModel;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantModel get result => _restaurantModel;

  ResultState get state => _state;

  Future<dynamic> _fetchRestoList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await apiService.restoList();
      if (restaurantList.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantModel = restaurantList;
      }
    } on SocketException catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No internet connection';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
