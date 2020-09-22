import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_launch_tracker/non_ui/json/launch.dart';
import 'package:spacex_launch_tracker/ui/countdown_page.dart';

final DateFormat _dateFormat = DateFormat('dd/MM/yy');

class ItemHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mission',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  'Launch site',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
          Text(
            'Date (UTC)',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}

class ItemData extends StatelessWidget {
  ItemData(this._launch);

  final Launch _launch;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        CountdownPage.route,
        arguments: _launch,
      ),
      behavior: HitTestBehavior.opaque,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _launch.missionName,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    if (_launch.launchSite.siteName != null &&
                        _launch.launchSite.siteName != '')
                      Text(
                        _launch.launchSite.siteName,
                        style: Theme.of(context).textTheme.caption,
                      ),
                  ],
                ),
              ),
              Text(
                _dateFormat.format(
                  DateTime.fromMillisecondsSinceEpoch(
                    _launch.launchDateUnix * 1000,
                  ),
                ),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
