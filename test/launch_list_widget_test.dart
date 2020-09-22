import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:spacex_launch_tracker/non_ui/launch_provider.dart';
import 'package:spacex_launch_tracker/ui/launch_list_widget.dart';

import 'provider_mocks.dart';

const _missionName = ProviderMocks.missionName;
const _launchSiteName = ProviderMocks.launchSiteName;

void main() {
  MockClient _client;
  MockStorage _storage;
  Widget _widget;

  group('List of launches', () {
    setUp(() {
      _client = ProviderMocks.setUpClient();
      _storage = ProviderMocks.setUpStorage();
      _widget = ChangeNotifierProvider(
        create: (_) => LaunchProvider(_client, _storage),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Consumer<LaunchProvider>(
            builder: (_, __, ___) {
              return LaunchListWidget();
            },
          ),
        ),
      );
    });

    testWidgets('One launch displayed in list', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();

      expect(find.text('Mission'), findsOneWidget);
      expect(find.text('Launch site'), findsOneWidget);
      expect(find.text('Date (UTC)'), findsOneWidget);
      expect(find.text(_missionName), findsOneWidget);
      expect(find.text(_launchSiteName), findsOneWidget);
    });
  });
}
