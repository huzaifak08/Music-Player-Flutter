import 'package:flutter/material.dart';
import 'package:music_player/Screens/item_screen.dart';
import 'package:music_player/Services/songs_services.dart';
import 'package:music_player/Utils/song_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SongServices songServices = SongServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Songs"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: songServices.getLatestSongs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data Available'));
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: songServices.latestSongsList.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemScreen(
                              songModel: songServices.latestSongsList[index]),
                        )),
                    child: SongCard(
                        songModel: songServices.latestSongsList[index]));
              },
            );
          }
        },
      ),
    );
  }
}
