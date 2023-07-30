import 'package:flutter/material.dart';
import 'package:mon_potager/models/FYP_Video.dart';
import '../posts/post_1.dart';
import '../posts/post_2.dart';
import '../posts/post_3.dart';
import '../posts/post_4.dart';
import '../posts/post_5.dart';
import '../posts/post_6.dart';
import '../posts/post_7.dart';
import '../posts/post_8.dart';
import '../posts/post_9.dart';
import '../posts/post_10.dart';


class ForYou extends StatefulWidget {
  const ForYou({Key? key}) : super(key: key);

  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {

  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close, color: Colors.white, size: 40,))
        ],
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: _controller,
        children:  [

          FYP_Video("assets/videos/1.mp4"),
          FYP_Video("assets/videos/2.mp4"),
          FYP_Video("assets/videos/3.mp4"),
          FYP_Video("assets/videos/4.mp4"),
          FYP_Video("assets/videos/5.mp4"),
          FYP_Video("assets/videos/6.mp4"),
          FYP_Video("assets/videos/7.mp4"),
          FYP_Video("assets/videos/8.mp4"),
          FYP_Video("assets/videos/9.mp4"),
          FYP_Video("assets/videos/10.mp4"),

        ],
      ),
    );
  }
}
