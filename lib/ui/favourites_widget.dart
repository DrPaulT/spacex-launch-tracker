import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex_launch_tracker/non_ui/json/launch.dart';
import 'package:spacex_launch_tracker/non_ui/launch_provider.dart';
import 'package:spacex_launch_tracker/ui/item_widget.dart';

class FavouritesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LaunchProvider launchProvider = context.watch<LaunchProvider>();
    List<Launch> favourites = launchProvider.favourites;
    if (favourites.length == 0) {
      return _NoFavourites();
    }
    return _FavouritesList(favourites);
  }
}

class _NoFavourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No favourites yet',
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

class _FavouritesList extends StatelessWidget {
  _FavouritesList(this._favourites);

  final List<Launch> _favourites;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) {
        return ItemData(_favourites[index]);
      },
      separatorBuilder: (_, __) => Divider(
        color: Colors.white,
        thickness: 1,
        height: 1,
      ),
      itemCount: _favourites.length,
    );
  }
}
