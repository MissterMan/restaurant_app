import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/resto_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              restaurant.rating.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: restaurant.pictureId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    restaurant.pictureId,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                restaurant.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Chip(
                elevation: 2,
                shadowColor: secondaryColor,
                backgroundColor: secondaryColor,
                label: Text(
                  restaurant.city,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                avatar: const Icon(
                  Icons.location_on_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'Description',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                restaurant.description,
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
                children: restaurant.menus.foods
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
                children: restaurant.menus.drinks
                    .map(
                      (e) => ListTile(
                        title: Text(e.name),
                      ),
                    )
                    .toList(),
              ),
              // Text(restsaurant.menus.foods.map((e) => e.name).toString()),
              // FutureBuilder(
              //   future: DefaultAssetBundle.of(context)
              //       .loadString('assets/restaurant.json'),
              //   builder: (context, snapshot) {
              //     var jsonMap = jsonDecode(snapshot.data as String);
              //     var minuman = Menus.fromJson(jsonMap);
              //     return ListView.builder(
              //       itemCount: minuman.drinks.length,
              //       itemBuilder: (context, index) {
              //         return _buildDrinksItem(context, minuman.drinks[index]);
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
