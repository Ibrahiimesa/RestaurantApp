import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/preferences_provider.dart';
import '../provider/scheduling_provider.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting_app';

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Consumer<PreferencesProvider>(
        builder: (_, provider, __) {
          return Consumer<SchedulingProvider>(
            builder: (_, scheduled, __) {
              return SwitchListTile(
                title: const Text('Daily Reminder'),
                value: provider.isDailyRestaurantActive,
                onChanged: (value) async {
                  scheduled.scheduledRestaurant(value);
                  provider.enableDailyRestaurant(value);
                },
              );
            },
          );
        },
      ),
    );
  }
}
