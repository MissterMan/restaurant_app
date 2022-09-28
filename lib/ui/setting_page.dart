import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = '/setting_page';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Material(
        child: Consumer<PreferencesProvider>(
          builder: (context, provider, child) {
            return ListTile(
              title: const Text('Resto App Notification'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: provider.isDailyRestoActivate,
                    onChanged: (value) async {
                      scheduled.scheduleFavorit(value);
                      provider.enableDailyResto(value);
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
