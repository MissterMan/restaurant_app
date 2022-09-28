import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/favorit_page.dart';
import 'package:restaurant_app/ui/restaurant_detail.dart';
import 'package:restaurant_app/ui/restaurant_search.dart';
import 'package:restaurant_app/ui/setting_page.dart';
import 'package:restaurant_app/widget/resto_card.dart';
import '../data/models/restaurant.dart';
import '../util/result_state.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  final searchController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _random = Random();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget _buildList() {
    return Consumer<RestoProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFFFF5B00),
              ),
            ),
          );
        } else if (state.state == ResultState.hasData) {
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: _globalKey,
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Cari Restaurant',
                        filled: true,
                        fillColor: const Color(0xFFFF5B00),
                      ),
                      onFieldSubmitted: (query) {
                        if (query == null || query.isEmpty) {
                          return null;
                        } else {
                          Navigator.pushNamed(
                              context, RestaurantSearchPage.routeName,
                              arguments: query);
                        }
                      },
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result.restaurants[index];
                    return RestoCard(restaurant: restaurant);
                  },
                ),
              ],
            ),
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, FavoritPage.routeName);
              },
              icon: const Icon(
                Icons.favorite_border,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SettingsPage.routeName);
              },
              icon: const Icon(
                Icons.settings_outlined,
              ),
            )
          ],
          title: const Text(
            'Restaurant',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: _buildList());
  }
}
