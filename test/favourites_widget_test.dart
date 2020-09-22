import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:spacex_launch_tracker/non_ui/json/launch.dart';
import 'package:spacex_launch_tracker/non_ui/json/launch_site.dart';
import 'package:spacex_launch_tracker/non_ui/launch_provider.dart';
import 'package:spacex_launch_tracker/ui/favourites_widget.dart';

import 'provider_mocks.dart';

const _missionName = ProviderMocks.missionName;
const _launchDateUnix = ProviderMocks.launchDateUnix;
const _launchSiteId = ProviderMocks.launchSiteId;
const _launchSiteName = ProviderMocks.launchSiteName;

void main() {
  MockClient _client;
  MockStorage _storage;
  LaunchProvider _lp;
  Widget _widget;

  group('Favourites list', () {
    setUp(() {
      _client = ProviderMocks.setUpClient();
      _storage = ProviderMocks.setUpStorage();
      _widget = ChangeNotifierProvider(
        create: (_) => LaunchProvider(_client, _storage),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Consumer<LaunchProvider>(
            builder: (_, value, __) {
              _lp = value;
              return FavouritesWidget();
            },
          ),
        ),
      );
    });

    testWidgets('One favourite displayed in list', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();

      expect(find.text(_missionName), findsOneWidget);
      expect(find.text(_launchSiteName), findsOneWidget);
    });

    testWidgets('No favourites found', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();

      Launch l = Launch(
        _missionName,
        _launchDateUnix,
        LaunchSite(_launchSiteId, _launchSiteName),
      );
      _lp.toggleFavourite(l);
      await tester.pumpAndSettle();

      expect(find.text('No favourites yet'), findsOneWidget);
    });
  });
}
