import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

import '../data/api/api_services.dart';
import '../data/models/restaurant.dart';
import '../provider/database_provider.dart';
import '../util/result_state.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/resto_detail';

  // final String id;
  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestoDetailProvider>(
      create: (_) =>
          RestoDetailProvider(apiService: ApiService(), id: restaurant.id),
      child: Consumer<RestoDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFFFF5B00),
              ),
            ));
          } else if (state.state == ResultState.hasData) {
            return Scaffold(
              appBar: AppBar(
                foregroundColor: Colors.black,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.result.restaurant.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      state.result.restaurant.rating.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              body: Consumer<DatabaseProvider>(
                builder: (context, provider, child) {
                  return FutureBuilder<bool>(
                    future: provider.isFavorited(restaurant.id),
                    builder: (context, snapshot) {
                      var isFavorited = snapshot.data ?? false;
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Hero(
                                tag: state.result.restaurant.pictureId,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        'https://restaurant-api.dicoding.dev/images/large/${state.result.restaurant.pictureId}',
                                        width: double.infinity,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              isFavorited
                                  ? IconButton(
                                      onPressed: () => provider.removeFavorit(
                                          state.result.restaurant.id),
                                      icon: const Icon(Icons.favorite),
                                      color: Colors.redAccent,
                                    )
                                  : IconButton(
                                      onPressed: () =>
                                          provider.addFavorit(restaurant),
                                      icon: const Icon(Icons.favorite_border),
                                      color: Colors.redAccent,
                                    ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                state.result.restaurant.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    state.result.restaurant.address,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    state.result.restaurant.city,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: state.result.restaurant.categories
                                    .map(
                                      (e) => Row(
                                        children: [
                                          Chip(
                                            backgroundColor: secondaryColor,
                                            label: Text(
                                              e.name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          )
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Description',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                state.result.restaurant.description,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.caption,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                'Makanan',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: state.result.restaurant.menus.foods
                                    .map(
                                      (e) => ListTile(
                                        title: Text(e.name),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                'Minuman',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: state.result.restaurant.menus.drinks
                                    .map(
                                      (e) => ListTile(
                                        title: Text(e.name),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const Text(
                                'Review',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    state.result.restaurant.customerReviews
                                        .map(
                                          (e) => ListTile(
                                            title: Text(e.name),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(e.review),
                                                Text(e.date),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
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
