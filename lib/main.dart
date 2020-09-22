import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spacex_launch_tracker/ui/spacex_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(SpaceXApp());
  });
}
