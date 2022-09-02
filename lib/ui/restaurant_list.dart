import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/restaurant_detail.dart';
import '../data/models/restaurant.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Restaurant',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future:
            DefaultAssetBundle.of(context).loadString('assets/restaurant.json'),
        builder: (context, snapshot) {
          var jsonMap = jsonDecode(snapshot.data.toString());
          var resto = RestaurantModel.fromJson(jsonMap);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListView.builder(
              itemCount: resto.restaurants.length,
              itemBuilder: (context, index) {
                return _buildRestoItem(context, resto.restaurants[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

Widget _buildRestoItem(BuildContext context, Restaurant restaurant) {
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
                arguments: restaurant,
              );
            },
            leading: Hero(
              tag: restaurant.pictureId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  restaurant.pictureId,
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
