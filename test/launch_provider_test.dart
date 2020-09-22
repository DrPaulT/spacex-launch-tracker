import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:spacex_launch_tracker/non_ui/json/launch.dart';
import 'package:spacex_launch_tracker/non_ui/launch_provider.dart';

import 'provider_mocks.dart';

const _missionName = ProviderMocks.missionName;
const _launchDateUnix = ProviderMocks.launchDateUnix;
const _launchSiteName = ProviderMocks.launchSiteName;

void main() {
  MockClient _client;
  MockStorage _storage;

  group('Launch provider', () {
    setUp(() {
      _client = ProviderMocks.setUpClient();
      _storage = ProviderMocks.setUpStorage();
    });

    testWidgets('Provider initialised properly', (WidgetTester tester) async {
      LaunchProvider lp = await _createLp(tester, _client, _storage);
      expect(lp.launches.length, 1);
      Launch l = lp.launches[0];
      expect(l.missionName, _missionName);
      expect(l.launchDateUnix, _launchDateUnix);
      expect(l.launchSite.siteName, _launchSiteName);
      expect(lp.favourites.length, 1);
      expect(lp.favourites[0].missionName, _missionName);
    });

    testWidgets('Is favourite', (WidgetTester tester) async {
      LaunchProvider lp = await _createLp(tester, _client, _storage);
      Launch l = Launch(_missionName, null, null);
      expect(lp.isFavourite(l), true);
      l = Launch('Banana', null, null);
      expect(lp.isFavourite(l), false);
    });

    testWidgets('Toggle favourite', (WidgetTester tester) async {
      LaunchProvider lp = await _createLp(tester, _client, _storage);
      Launch l = Launch(_missionName, _launchDateUnix, null);
      await lp.toggleFavourite(l);
      expect(lp.isFavourite(l), false);
      expect(lp.favourites.length, 0);
      await lp.toggleFavourite(l);
      expect(lp.isFavourite(l), true);
      expect(lp.favourites.length, 1);
    });

    testWidgets('Clean up method sorts correctly', (WidgetTester tester) async {
      LaunchProvider lp = await _createLp(tester, _client, _storage);
      Launch l = Launch(_missionName, _launchDateUnix, null);
      await lp.toggleFavourite(l); // Remove the existing favourite.
      Launch l0 = Launch('Zero', _launchDateUnix + 2, null);
      Launch l1 = Launch('One', _launchDateUnix + 1, null);
      Launch l2 = Launch('Two', _launchDateUnix + 0, null);
      await lp.toggleFavourite(l0);
      await lp.toggleFavourite(l1);
      await lp.toggleFavourite(l2);
      expect(lp.favourites[0].missionName, 'Two');
      expect(lp.favourites[1].missionName, 'One');
      expect(lp.favourites[2].missionName, 'Zero');
    });
  });
}

Future<LaunchProvider> _createLp(
  WidgetTester tester,
  MockClient client,
  MockStorage storage,
) async {
  LaunchProvider lp;
  await tester.pumpWidget(
    ChangeNotifierProvider(
      create: (_) => LaunchProvider(client, storage),
      child: Consumer<LaunchProvider>(
        builder: (_, value, __) {
          lp = value;
          return Container();
        },
      ),
    ),
  );
  return lp;
}
