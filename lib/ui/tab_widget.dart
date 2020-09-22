import 'package:flutter/material.dart';
import 'package:spacex_launch_tracker/ui/favourites_widget.dart';
import 'package:spacex_launch_tracker/ui/launch_list_widget.dart';

class TabWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              SizedBox(
                height: 48,
                child: Center(
                  child: Text(
                    'All launches',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              SizedBox(
                height: 48,
                child: Center(
                  child: Text(
                    'Favourites',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                LaunchListWidget(),
                FavouritesWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
