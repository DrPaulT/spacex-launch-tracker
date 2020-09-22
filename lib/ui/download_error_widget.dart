import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:spacex_launch_tracker/non_ui/launch_provider.dart';

class DownloadErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Download error', style: Theme.of(context).textTheme.headline5),
          Padding(
            padding: const EdgeInsets.fromLTRB(64, 16, 64, 128),
            child: Text(
              'There was a problem fetching launch information.',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          FlatButton(
            onPressed: () => Provider.of<LaunchProvider>(context, listen: false)
                .downloadData(Client()),
            child: Text('TRY AGAIN'),
          ),
        ],
      ),
    );
  }
}
