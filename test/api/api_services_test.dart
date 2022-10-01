import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

import 'api_services_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group(
    'Fetch Restaurant data from API',
    () {
      test(
        'Return RestaurantModel if fetching data is completes successfully',
        () async {
          final client = MockClient();

          when(
            client.get(
              Uri.parse('https://restaurant-api.dicoding.dev/list'),
            ),
          ).thenAnswer(
            (_) async => http.Response(
                '{"error": false, "message": "success", "count": 20, "restaurants": []}',
                200),
          );
          expect(await ApiService().restoList(), isA<RestaurantModel>());
        },
      );
    },
  );
}
