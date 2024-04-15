import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gitachanting/SloksList.dart';

class SloksCard extends StatefulWidget {

  final slokno, slok, audiosrc, slokdetail, Detailaudio,ch;

  SloksCard(this.slokno, this.slok, this.audiosrc, this.slokdetail, this.Detailaudio,this.ch);

  @override
  State<SloksCard> createState() => _SloksCardState();

}

class _SloksCardState extends State<SloksCard> {

  final audioPlayer = AudioPlayer();
  final audioPlayer2 = AudioPlayer();
  bool isPlaying = false;
  bool isPlaying2 = false;
  Duration duration = Duration.zero;
  Duration detailDuration = Duration.zero;
  Duration position = Duration.zero;
  Duration detailPosition = Duration.zero;


  @override
  void initState() {
    super.initState();

    setAudio();

    /// listen to stated :playing , paused , stopped
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer2.onPlayerStateChanged.listen((state2) {
      setState(() {
        isPlaying2 = state2 == PlayerState.playing;
      });
    });

    /// listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer2.onDurationChanged.listen((newDuration2) {
      setState(() {
        detailDuration = newDuration2;
      });
    });

    /// listen to audio position
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    audioPlayer2.onPositionChanged.listen((newPosition2) {
      setState(() {
        detailPosition = newPosition2;
      });
    });
  }

  // To dispose audioPlayer when not in use to avoid unwanted storage usage
  @override
  void dispose() {
    audioPlayer.dispose();
    audioPlayer2.dispose();
    super.dispose();
  }

  Future setAudio()async {
      /// repeat song when completed
      audioPlayer.setReleaseMode(ReleaseMode.loop);
      audioPlayer2.setReleaseMode(ReleaseMode.loop);

    }

  String formatDurationInMmSs(Duration duration) {
    final mm = (duration.inMinutes % 60).toString().padLeft(2, '0');

    final ss = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {

    var mediaQuery = MediaQuery.of(context);

    return WillPopScope(

        onWillPop: () async {
          onBackPressed();
          return false;
        },

        child: Scaffold(

          appBar: AppBar(
            title: Text("श्लोक ${widget.slokno}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),

          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/images/bckground.jpg"),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 4,
                        color: Colors.grey,
                        offset: Offset(0, 6))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "श्लोक ${widget.slokno}",
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: mediaQuery.size.width * 0.8,
                    child: Text(
                      widget.slok,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Slider(
                      min: 0,
                      max: detailDuration.inSeconds.toDouble(),
                      value: detailPosition.inSeconds.toDouble(),
                      onChanged: (value2) async {
                        final position2 = Duration(seconds: value2.toInt());
                        await audioPlayer2.seek(position2);

                        /// Play if audio was paused
                        await audioPlayer2.resume();
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatDurationInMmSs(detailPosition),
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(formatDurationInMmSs(detailDuration),
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: mediaQuery.size.width * 0.12,
                    child: CircleAvatar(
                      radius: 40,
                      child: IconButton(
                          onPressed: () async {
                            if (isPlaying2) {
                              await audioPlayer2.pause();
                            } else {
                              await audioPlayer2
                                  .play(UrlSource(widget.Detailaudio));
                            }
                          },
                          icon: Icon(
                              isPlaying2 ? Icons.pause : Icons.play_arrow)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "व्याख्या",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: mediaQuery.size.width * 0.8,
                    child: Text(
                      widget.slokdetail,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
                        await audioPlayer.seek(position);

                        /// Play if audio was paused
                        await audioPlayer.resume();
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatDurationInMmSs(position),
                            style: const TextStyle(color: Colors.white)),
                        Text(formatDurationInMmSs(duration),
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: mediaQuery.size.width * 0.12,
                    child: CircleAvatar(
                      radius: 40,
                      child: IconButton(
                          onPressed: () async {
                            if (isPlaying) {
                              await audioPlayer.pause();
                            } else {
                              await audioPlayer
                                  .play(UrlSource(widget.audiosrc));
                            }
                          },
                          icon:
                              Icon(isPlaying ? Icons.pause : Icons.play_arrow)),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  )

                ],
              ),
            ),
          ),
        ));
  }


  void onBackPressed() {
    audioPlayer.stop();
    audioPlayer2.stop();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SloksList(widget.ch)));
  }

}
