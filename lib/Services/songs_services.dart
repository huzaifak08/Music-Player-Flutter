import 'dart:convert';

import 'package:music_player/Models/song_model.dart';
import 'package:http/http.dart' as http;

class SongServices {
  List<SongModel> latestSongsList = [];

  Future<List<SongModel>> getLatestSongs() async {
    final request = await http.get(Uri.parse(
        "https://itunes.apple.com/search?term=latest&country=us&media=music"));

    var response = jsonDecode(request.body);

    List<dynamic> data = response['results'];

    if (request.statusCode == 200) {
      latestSongsList.clear();

      for (Map<String, dynamic> i in data) {
        latestSongsList.add(SongModel.fromJson(i));
      }
    }
    return latestSongsList;
  }
}
