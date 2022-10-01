import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/db/db_helper.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/util/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorit();
  }

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorit = [];
  List<Restaurant> get favorit => _favorit;

  void _getFavorit() async {
    _favorit = await databaseHelper.getFavorit();
    if (_favorit.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Tambahkan Resto Favorit Anda';
    }
    notifyListeners();
  }

  void addFavorit(Restaurant restaurant) async {
    try {
      await databaseHelper.addFavorit(restaurant);
      _getFavorit();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Failed to load data';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedResto = await databaseHelper.getFavoritById(id);
    return favoritedResto.isNotEmpty;
  }

  void removeFavorit(String id) async {
    try {
      await databaseHelper.removeFavorit(id);
      _getFavorit();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Failed to remove data';
      notifyListeners();
    }
  }
}
