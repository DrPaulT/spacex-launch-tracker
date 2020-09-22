import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:spacex_launch_tracker/non_ui/json/launch.dart';
import 'package:spacex_launch_tracker/non_ui/launch_provider.dart';
import 'package:spacex_launch_tracker/ui/download_error_widget.dart';
import 'package:spacex_launch_tracker/ui/tab_widget.dart';
import 'package:spacex_launch_tracker/ui/waiting_widget.dart';

const _title = 'Upcoming Launches';

class UpcomingLaunchesPage extends StatelessWidget {
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    LaunchProvider launchProvider = context.watch<LaunchProvider>();
    Widget child = WaitingWidget();
    if (launchProvider.error) {
      child = DownloadErrorWidget();
    } else if (launchProvider.launches.length > 0) {
      child = TabWidget();
    }
    return Scaffold(
      appBar: AppBar(
        // On Android you would probably allow align-left.
        // On iOS and web, it will automatically centre anyway.
        centerTitle: true,
        title: Text(_title),
        toolbarHeight: 96,
        // This looks like a ghastly hack.
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: <Color>[
                Color.fromARGB(255, 169, 86, 136),
                Color.fromARGB(255, 64, 26, 85),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: () => _share(context)),
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: <Color>[
                Color.fromARGB(255, 57, 42, 56),
                Color.fromARGB(255, 38, 32, 48),
              ],
            ),
          ),
          child: child),
    );
  }

  void _share(BuildContext context) {
    Launch nextLaunch = Provider.of<LaunchProvider>(
      context,
      listen: false,
    ).launches[0];
    String mission = nextLaunch.missionName;
    String when = DateFormat.MMMMEEEEd().format(
      DateTime.fromMillisecondsSinceEpoch(nextLaunch.launchDateUnix * 1000),
    );
    String site = nextLaunch.launchSite.siteName;
    Share.share(
      'Check out the launch of $mission from SpaceX at launch site $site on $when: https://spacex.com',
    );
  }
}
