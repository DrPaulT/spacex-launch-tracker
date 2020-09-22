import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex_launch_tracker/non_ui/json/launch.dart';
import 'package:spacex_launch_tracker/non_ui/launch_provider.dart';
import 'package:spacex_launch_tracker/ui/item_widget.dart';

class LaunchListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LaunchProvider launchProvider = context.watch<LaunchProvider>();
    List<Launch> launches = launchProvider.launches;
    return ListView.separated(
      itemBuilder: (_, index) {
        if (index == 0) {
          return ItemHeader();
        }
        return ItemData(launches[index - 1]);
      },
      separatorBuilder: (_, __) => Divider(
        color: Colors.white,
        thickness: 1,
        height: 1,
      ),
      itemCount: launches.length + 1,
    );
  }
}
