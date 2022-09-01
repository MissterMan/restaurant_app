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
          var jsonMap = jsonDecode((snapshot.data ?? []).toString());
          var resto = RestaurantModel.fromJson(jsonMap);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GridView.builder(
              itemCount: resto.restaurants.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 4.5,
              ),
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
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: restaurant.pictureId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  restaurant.pictureId,
                  // height: 100,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      restaurant.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 14,
                          color: Colors.redAccent,
                        ),
                        Text(restaurant.city),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 14,
                        ),
                        Text(
                          restaurant.rating.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
