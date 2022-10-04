import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/widget/resto_card.dart';

import '../util/result_state.dart';

class FavoritPage extends StatelessWidget {
  static const routeName = 'Favorit';

  const FavoritPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.black,
              title: const Text(
                'Restaurant Favorit',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            body: ListView.builder(
              itemCount: provider.favorit.length,
              itemBuilder: (context, index) {
                return RestoCard(restaurant: provider.favorit[index]);
              },
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.black,
              title: const Text(
                'Restaurant Favorit',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            body: Center(
              child: Material(
                child: Text(provider.message),
              ),
            ),
          );
        }
      },
    );
  }
}
