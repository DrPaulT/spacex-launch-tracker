import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:spacex_launch_tracker/non_ui/storage.dart';
import 'package:spacex_launch_tracker/non_ui/launch_provider.dart';
import 'package:spacex_launch_tracker/ui/countdown_page.dart';
import 'package:spacex_launch_tracker/ui/upcoming_launches_page.dart';

class SpaceXApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LaunchProvider(Client(), Storage()),
      child: MaterialApp(
        title: 'SpaceX',
        theme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.indigoAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: UpcomingLaunchesPage.route,
        routes: {
          UpcomingLaunchesPage.route: (_) => UpcomingLaunchesPage(),
          CountdownPage.route: (_) => CountdownPage(),
        },
      ),
    );
  }
}
