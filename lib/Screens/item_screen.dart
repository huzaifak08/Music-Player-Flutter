import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Models/song_model.dart';

class ItemScreen extends StatefulWidget {
  final SongModel songModel;
  const ItemScreen({super.key, required this.songModel});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();

  Timer? timer;

  int sliderValue = 0;

  bool _isPlaying = false;

  void periodicUpdate() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (sliderValue < 30) {
        setState(() {
          sliderValue++;
        });
      } else {
        setState(() {
          _isPlaying = false;
        });

        stopPeriodicUpdate();
      }
    });
  }

  void stopPeriodicUpdate() {
    timer!.cancel();
  }

  void playMusic(String audioUrl) async {
    if (sliderValue == 30) {
      setState(() {
        sliderValue = 0;
      });
    }

    await audioPlayer.play(UrlSource(audioUrl),
        position: Duration(seconds: sliderValue));

    periodicUpdate();
  }

  void stopMusic() async {
    audioPlayer.stop();
    stopPeriodicUpdate();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    stopMusic();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.02, vertical: height * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height * 0.5,
              width: width,
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.01, vertical: height * 0.01),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(23),
              ),
              child: Image.network(
                widget.songModel.artworkUrl100!,
                fit: BoxFit.cover,
              ),
            ),
            Slider(
              activeColor: Colors.red,
              inactiveColor: Colors.grey,
              min: 0,
              max: 30,
              value: sliderValue.toDouble(),
              onChanged: (value) {
                setState(() {
                  stopMusic();
                  sliderValue = value.toInt();
                  _isPlaying = false;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '00 : ${sliderValue.toString().length == 1 ? '0$sliderValue' : sliderValue}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                    )),
                const Text(
                  '00 : 30',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.03),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.replay_10, size: 40),
                Row(
                  children: [
                    const Icon(Icons.skip_previous, size: 40),
                    GestureDetector(
                        onTap: () {
                          if (_isPlaying) {
                            stopMusic();
                          } else {
                            playMusic(widget.songModel.previewUrl!);
                          }
                          setState(() {
                            _isPlaying = !_isPlaying;
                          });
                        },
                        child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 40)),
                    const Icon(Icons.skip_next, size: 40)
                  ],
                ),
                const Icon(Icons.repeat_rounded, size: 40)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
