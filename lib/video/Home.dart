import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:listtodo/Home/home_page.dart';
import 'package:listtodo/video/api_video.dart';
import 'package:listtodo/video/video_model.dart';
import 'package:listtodo/video/videos.dart';
import 'package:video_player/video_player.dart';


class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Video> videoList = <Video>[];

  void getVideoFromAPI() async {
    VideoAPI.getVideo().then((response) {
      setState(() {
        var responseData = json.decode(response.body);
        print(responseData);
        Iterable lista = responseData;
        videoList =
            lista.map((model) => Video.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    getVideoFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Flutter Video Player Demo'),
        centerTitle: true,
      ),
      body:
        ListView.builder(
          itemCount: videoList.length,
          itemBuilder: (context, index) {
            return VideoItems(
              videoPlayerController: VideoPlayerController.network(
                  videoList[index].url
              ),
              looping: false,
              autoplay: true,
            );
          })
    );
  }
}