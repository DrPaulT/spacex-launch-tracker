import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:spacex_launch_tracker/non_ui/json/launch.dart';
import 'package:spacex_launch_tracker/non_ui/storage.dart';

class LaunchProvider with ChangeNotifier {
  LaunchProvider(Client client, this._storage) {
    downloadData(client);
  }

  @visibleForTesting
  static const upcomingUrl = 'https://api.spacexdata.com/v3/launches/upcoming';

  List<Launch> launches = [];
  List<Launch> favourites = [];
  bool error = false;
  Storage _storage;

  Future<void> downloadData(Client client) async {
    try {
      error = false;
      notifyListeners();
      Response response = await client.get(upcomingUrl);
      if (response.statusCode == 200) {
        (jsonDecode(response.body) as List).forEach((j) {
          launches.add(Launch.fromJson(j));
        });
        cleanUp(launches);
      } else {
        print(
          'There was a problem fetching launch data: ${response.statusCode} ${response.reasonPhrase}',
        );
        error = true;
      }
    } catch (e) {
      print('There was a network error: $e');
      error = true;
    } finally {
      client.close();
    }
    List<String> missionNames = await _storage.loadFavourites();
    favourites = List.from(launches, growable: true)
      ..retainWhere((f) => missionNames.contains(f.missionName));
    cleanUp(favourites);
    notifyListeners();
  }

  bool isFavourite(Launch launch) =>
      favourites.any((l) => l.missionName == launch.missionName);

  Future<void> toggleFavourite(Launch launch) async {
    if (isFavourite(launch)) {
      favourites.removeWhere((l) => launch.missionName == l.missionName);
    } else {
      favourites.add(launch);
      cleanUp(favourites);
    }
    await _storage.saveFavourites(
      favourites.map((f) => f.missionName).toList(),
    );
    notifyListeners();
  }

  void cleanUp(List<Launch> launches) {
    // Remove any launch in the past.
    int nowSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    launches.removeWhere((l) => l.launchDateUnix < nowSeconds);
    // Sort soonest first.
    launches.sort((a, b) => a.launchDateUnix.compareTo(b.launchDateUnix));
  }
}
