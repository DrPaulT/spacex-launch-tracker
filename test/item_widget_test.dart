import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_launch_tracker/non_ui/json/launch.dart';
import 'package:spacex_launch_tracker/non_ui/json/launch_site.dart';
import 'package:spacex_launch_tracker/ui/item_widget.dart';

import 'provider_mocks.dart';

const _missionName = ProviderMocks.missionName;
const _launchDateUnix = ProviderMocks.launchDateUnix;
const _launchSiteId = ProviderMocks.launchSiteId;
const _launchSiteName = ProviderMocks.launchSiteName;

void main() {
  group('List item rows', () {
    testWidgets('Item header', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(textDirection: TextDirection.ltr, child: ItemHeader()),
      );
      expect(find.text('Mission'), findsOneWidget);
      expect(find.text('Launch site'), findsOneWidget);
      expect(find.text('Date (UTC)'), findsOneWidget);
    });

    testWidgets('Item data', (WidgetTester tester) async {
      Launch l = Launch(
        _missionName,
        _launchDateUnix,
        LaunchSite(_launchSiteId, _launchSiteName),
      );
      await tester.pumpWidget(
        Directionality(textDirection: TextDirection.ltr, child: ItemData(l)),
      );
      expect(find.text(_missionName), findsOneWidget);
      expect(find.text(_launchSiteName), findsOneWidget);
    });
  });
}
