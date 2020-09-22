import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:spacex_launch_tracker/non_ui/launch_provider.dart';
import 'package:spacex_launch_tracker/non_ui/storage.dart';

class ProviderMocks {
  static const missionName = 'SAOCOM 1B, GNOMES-1, Tyvak-0172';
  static const launchDateUnix = 1608829480;
  static const launchSiteId = 'ccafs_slc_40';
  static const launchSiteName = 'CCAFS SLC 40';

  static const String _json = '''[
  {
    "mission_name":"$missionName",
    "launch_date_unix":$launchDateUnix,
    "launch_site":{
      "site_id":"ccafs_slc_40",
      "site_name":"$launchSiteName",
      "site_name_long":"Cape Canaveral Air Force Station Space Launch Complex 40"
    }
  }
]''';

  static MockClient setUpClient() {
    MockClient client = MockClient();
    when(client.get(LaunchProvider.upcomingUrl))
        .thenAnswer((_) async => Response(_json, 200));
    return client;
  }

  static MockStorage setUpStorage() {
    MockStorage storage = MockStorage();
    when(storage.loadFavourites()).thenAnswer((_) async => [missionName]);
    return storage;
  }
}

class MockClient extends Mock implements Client {}

class MockStorage extends Mock implements Storage {}
