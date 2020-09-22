import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

const _fileName = 'favourites.json';

class Storage {
  Future<List<String>> loadFavourites() async {
    try {
      File file = await _file;
      if (await file.exists()) {
        return jsonDecode(await file.readAsString()).cast<String>();
      }
    } catch (e) {
      print('There was a file error while loading: $e');
    }
    return [];
  }

  Future<void> saveFavourites(List<String> missionNames) async {
    String json = jsonEncode(missionNames);
    try {
      File file = await _file;
      await file.writeAsString(json);
    } catch (e) {
      print('There was a file error while saving: $e');
    }
  }

  Future<File> get _file async {
    return File(
      (await getApplicationDocumentsDirectory()).path + '/$_fileName',
    );
  }
}
