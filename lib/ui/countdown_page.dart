import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:spacex_launch_tracker/non_ui/json/launch.dart';
import 'package:spacex_launch_tracker/non_ui/launch_provider.dart';

class CountdownPage extends StatefulWidget {
  static const route = '/countdown';

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage>
    with SingleTickerProviderStateMixin {
  Ticker _ticker;
  int _frameMillis = 0;

  void initState() {
    super.initState();
    _ticker = createTicker(_refresh);
    _ticker.start();
  }

  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Launch launch = ModalRoute.of(context).settings.arguments;
    LaunchProvider launchProvider = Provider.of<LaunchProvider>(
      context,
      listen: false,
    );
    Duration countdown = DateTime.fromMillisecondsSinceEpoch(
      launch.launchDateUnix * 1000,
    ).difference(DateTime.now());
    Duration days = Duration(days: countdown.inDays);
    Duration hours = Duration(hours: (countdown - days).inHours);
    Duration minutes = Duration(minutes: (countdown - days - hours).inMinutes);
    Duration seconds = Duration(
      seconds: (countdown - days - hours - minutes).inSeconds,
    );
    IconData favouriteIcon = Icons.favorite_outline;
    if (launchProvider.isFavourite(launch)) {
      favouriteIcon = Icons.favorite;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(launch.missionName),
        toolbarHeight: 96,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color.fromARGB(255, 84, 201, 192),
                Color.fromARGB(255, 85, 100, 112),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(favouriteIcon),
        onPressed: () => launchProvider.toggleFavourite(launch),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color.fromARGB(255, 35, 65, 67),
              Color.fromARGB(255, 37, 49, 54),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              days.inDays.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ),
            _BoxedText('DAYS'),
            Text(
              hours.inHours.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ),
            _BoxedText('HOURS'),
            Text(
              minutes.inMinutes.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ),
            _BoxedText('MINUTES'),
            Text(
              seconds.inSeconds.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ),
            _BoxedText('SECONDS'),
          ],
        ),
      ),
    );
  }

  void _refresh(Duration elapsed) {
    _frameMillis += elapsed.inMilliseconds;
    if (_frameMillis >= 1000) {
      _frameMillis = 0;
      setState(() {});
    }
  }
}

class _BoxedText extends StatelessWidget {
  _BoxedText(this._text);

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          _text,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
