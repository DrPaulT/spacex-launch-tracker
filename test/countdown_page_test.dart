import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:spacex_launch_tracker/non_ui/json/launch.dart';
import 'package:spacex_launch_tracker/non_ui/json/launch_site.dart';
import 'package:spacex_launch_tracker/non_ui/launch_provider.dart';
import 'package:spacex_launch_tracker/ui/countdown_page.dart';

import 'provider_mocks.dart';

const _missionName = ProviderMocks.missionName;
const _launchDateUnix = ProviderMocks.launchDateUnix;
const _launchSiteId = ProviderMocks.launchSiteId;
const _launchSiteName = ProviderMocks.launchSiteName;

void main() {
  MockClient _client;
  MockStorage _storage;
  Widget _widget;
  LaunchProvider _lp;
  Launch _launch = Launch(
    _missionName,
    _launchDateUnix,
    LaunchSite(_launchSiteId, _launchSiteName),
  );

  group('Launch countdown page', () {
    setUp(() {
      _client = ProviderMocks.setUpClient();
      _storage = ProviderMocks.setUpStorage();
      _widget = ChangeNotifierProvider(
        create: (_) => LaunchProvider(_client, _storage),
        child: MaterialApp(
          initialRoute: CountdownPage.route,
          routes: {CountdownPage.route: (_) => CountdownPage()},
          onGenerateInitialRoutes: (String initialRouteName) {
            return [
              MaterialPageRoute(
                builder: (_) => Consumer<LaunchProvider>(
                  builder: (_, value, __) {
                    _lp = value;
                    return CountdownPage();
                  },
                ),
                settings: RouteSettings(
                  name: CountdownPage.route,
                  arguments: _launch,
                ),
              ),
            ];
          },
        ),
      );
    });

    testWidgets('Countdown displayed as favourite',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pump(Duration(milliseconds: 150));

      expect(find.text(_missionName), findsOneWidget);
      expect(find.text('DAYS'), findsOneWidget);
      expect(find.text('HOURS'), findsOneWidget);
      expect(find.text('MINUTES'), findsOneWidget);
      expect(find.text('SECONDS'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('Countdown not favourite', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      _lp.toggleFavourite(_launch);
      await tester.pump(Duration(milliseconds: 150));

      expect(find.byIcon(Icons.favorite_outline), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
  });
}