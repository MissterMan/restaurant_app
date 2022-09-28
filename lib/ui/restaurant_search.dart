import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/models/restaurant_search_data.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/ui/restaurant_detail.dart';

import '../data/api/api_services.dart';
import '../util/result_state.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/resto_search';

  final String query;

  const RestaurantSearchPage({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestoSearchProvider>(
      create: (_) =>
          RestoSearchProvider(apiService: ApiService(), query: query),
      child: Consumer<RestoSearchProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return Center(
                child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                Color(0xFFFF5B00),
              ),
            ));
          } else if (state.state == ResultState.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                foregroundColor: Colors.black,
                title: const Text(
                  'Pencarian Restaurant',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Total restaurant ditemukan: ${state.result.founded.toString()}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.result.restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = state.result.restaurants[index];
                        return _buildRestaurantResult(context, restaurant);
                      },
                    )
                  ],
                ),
              ),
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Material(
                child: Scaffold(
                  body: Center(
                    child: Text(state.message),
                  ),
                ),
              ),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Material(
                child: Scaffold(
                  body: Center(
                    child: Text(state.message),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Material(
                child: Text(''),
              ),
            );
          }
        },
      ),
    );
  }
}

Widget _buildRestaurantResult(
    BuildContext context, RestaurantSearch restaurant) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
      },
      child: Column(
        children: [
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            onTap: () {
              Navigator.pushNamed(
                context,
                RestaurantDetailPage.routeName,
                arguments: restaurant.id,
              );
            },
            leading: Hero(
              tag: restaurant.pictureId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                  height: 150,
                ),
              ),
            ),
            title: Text(
              restaurant.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 14,
                      color: Colors.redAccent,
                    ),
                    Text(
                      restaurant.city,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: Colors.amberAccent,
                    ),
                    Text(restaurant.rating.toString()),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5.0,
          )
        ],
      ),
    ),
  );
}
