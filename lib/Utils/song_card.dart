import 'package:flutter/material.dart';
import 'package:music_player/Models/song_model.dart';

class SongCard extends StatelessWidget {
  final SongModel songModel;
  const SongCard({super.key, required this.songModel});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
      child: Container(
        height: height * 0.23,
        width: width * 0.4,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(23)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.17,
              child: Image.asset('assets/music.jpg'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: height * 0.01),
              child: Text(
                songModel.trackName.toString(),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
