import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/models/restaurant_detail_data.dart';

import '../util/result_state.dart';

class RestoDetailProvider extends ChangeNotifier {
  late final ApiService apiService;
  final String id;

  RestoDetailProvider({required this.apiService, required this.id}) {
    _fetchDetailResto();
  }

  late RestaurantModelDetail _restaurantModelDetail;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantModelDetail get result => _restaurantModelDetail;

  ResultState get state => _state;

  Future<dynamic> _fetchDetailResto() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.restoDetail(id);
      if (restaurantDetail.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Restaurant Found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantModelDetail = restaurantDetail;
      }
    } on SocketException catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No internet connection';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
