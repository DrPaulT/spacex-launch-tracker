import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:spacex_launch_tracker/non_ui/launch_provider.dart';
import 'package:spacex_launch_tracker/ui/upcoming_launches_page.dart';

import 'provider_mocks.dart';

const _missionName = ProviderMocks.missionName;
const _launchSiteName = ProviderMocks.launchSiteName;

void main() {
  MockClient _client;
  MockStorage _storage;
  Widget _widget;
  LaunchProvider _lp;

  group('Upcoming launches page', () {
    setUp(() {
      _client = ProviderMocks.setUpClient();
      _storage = ProviderMocks.setUpStorage();
      _widget = ChangeNotifierProvider(
        create: (_) => LaunchProvider(_client, _storage),
        child: MaterialApp(
          initialRoute: UpcomingLaunchesPage.route,
          routes: {
            UpcomingLaunchesPage.route: (_) => Consumer<LaunchProvider>(
                  builder: (_, value, __) {
                    _lp = value;
                    return UpcomingLaunchesPage();
                  },
                )
          },
        ),
      );
    });

    testWidgets('Provider has data ready', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.share), findsOneWidget);
      expect(find.text('Upcoming Launches'), findsOneWidget);
      expect(find.text('Mission'), findsOneWidget);
      expect(find.text('Launch site'), findsOneWidget);
      expect(find.text('Date (UTC)'), findsOneWidget);
      expect(find.text(_missionName), findsOneWidget);
      expect(find.text(_launchSiteName), findsOneWidget);
    });

    testWidgets('No data yet', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      _lp.launches = [];
      await tester.pump(Duration(milliseconds: 150));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('There was a network or server error',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      _lp.launches = [];
      _lp.error = true;
      await tester.pump(Duration(milliseconds: 150));
      expect(find.text('Download error'), findsOneWidget);
      expect(
        find.text('There was a problem fetching launch information.'),
        findsOneWidget,
      );
      expect(find.text('TRY AGAIN'), findsOneWidget);
    });
  });
}
