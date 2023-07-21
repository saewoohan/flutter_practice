
import 'package:riverpod/riverpod.dart';
import 'package:seventh_app/model/place.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';



class ListNotifier extends StateNotifier<List<Place>>{
  ListNotifier() : super(const []);

  final placeLists = [];

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    Place place = Place(title: title, image:copiedImage, location: location);

   final dbPath = await sql.getDatabasesPath();
   sql.openDatabase(path.join(dbPath, 'places.db'));
    state = [place, ...state];
  }

}

final placeProvider = StateNotifierProvider<ListNotifier, List<Place>>((ref) {
  return ListNotifier();
});

