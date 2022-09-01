import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/restaurant_list.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RestaurantListPage(),
    );
  }
}
