import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/db/db_helper.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

import '../provider/database_provider.dart';
import '../ui/restaurant_detail.dart';

class RestoCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestoCard({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
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
                      trailing: isFavorited
                          ? IconButton(
                              onPressed: () =>
                                  provider.removeFavorit(restaurant.id),
                              icon: const Icon(Icons.favorite),
                              color: Colors.redAccent,
                            )
                          : IconButton(
                              onPressed: () => provider.addFavorit(restaurant),
                              icon: const Icon(Icons.favorite_border),
                              color: Colors.redAccent,
                            ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
