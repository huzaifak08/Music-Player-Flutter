import 'package:flutter/material.dart';
import 'package:music_player/Screens/item_screen.dart';
import 'package:music_player/Services/songs_services.dart';

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
      backgroundColor: const Color.fromARGB(255, 53, 52, 52),
      appBar: AppBar(
        title: const Text(
          "Sheng Xue Music",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: FutureBuilder(
        future: songServices.getLatestSongs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data Available'));
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: songServices.latestSongsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemScreen(
                            songModel: songServices.latestSongsList[index]),
                      )),
                  title: Text(
                    songServices.latestSongsList[index].trackName.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    songServices.latestSongsList[index].artistName.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        songServices.latestSongsList[index].artworkUrl100!),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
