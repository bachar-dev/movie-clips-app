import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late VideoPlayerController _controller;

  List videos = [
    'assets/frozen2.mp4',
    'assets/kung2.mp4',
    'assets/raya.mp4',
    'assets/desp.mp4',
  ];
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(videos[selectedIndex])
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  void _updateVideo() {
    setState(() {
      _controller = VideoPlayerController.asset(videos[selectedIndex])
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text(
            'TRENDING MOVIE CLIPS',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          actions: const [
            Icon(Icons.search_sharp),
            SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(
                      height: 200,
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'DRAG UP  or DOWN TO SELECT A CLIP',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListWheelScrollView(
                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                      _updateVideo();
                    });
                  },
                  itemExtent: 200,
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/frozen.jpg')))),
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/kongfup.jpg',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/raya1.png',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/dis.jpg',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
