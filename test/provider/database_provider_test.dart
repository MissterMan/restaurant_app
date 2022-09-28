import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/db/db_helper.dart';
import 'package:restaurant_app/provider/database_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('Provider Test', () {
    test('Should not contain item when remove favorite restaurant', () {
      var databaseProvider = DatabaseProvider(databaseHelper: DatabaseHelper());
      var testModuleRestoId = 'Restaurant ID';

      databaseProvider.removeFavorit(testModuleRestoId);

      // ignore: iterable_contains_unrelated_type
      var result = databaseProvider.favorit.contains(testModuleRestoId);
      expect(result, false);
    });
  });
}
