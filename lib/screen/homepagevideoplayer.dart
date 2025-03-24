import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels/controller/homepagevideo_controller.dart';
import 'package:reels/model/postModel.dart';
import 'package:video_player/video_player.dart';

class TikTokHomePage extends StatefulWidget {
  @override
  _TikTokHomePageState createState() => _TikTokHomePageState();
}

class _TikTokHomePageState extends State<TikTokHomePage> {
  // final List<String> videoUrls = [
  //   'https://www.spasciani.com/wp-content/uploads/2019/10/big_buck_bunny_720p_1mb.mp4?_=2',
  //   'https://www.spasciani.com/wp-content/uploads/2019/10/big_buck_bunny_720p_1mb.mp4?_=2',
  //   // 'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_2mb.mp4',
  // ];

  late VideoController homepagecontroller;

  @override
  void initState() {
    super.initState();
    homepagecontroller = Get.put(VideoController());
    homepagecontroller.checkInternetAndFetchVideos();
  }

  /// Fetch posts from Firestore.

  /// Initialize video controllers for each post.

  // @override
  // void dispose() {
  //   for (var controller in homepagecontroller.controllers) {
  //     controller.dispose();
  //   }
  //   homepagecontroller.pageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // Show a loading indicator while posts are being fetched.
    if (homepagecontroller.isLoading.value) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(body: Obx(
      () {
        if (homepagecontroller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: homepagecontroller.posts.length,
          onPageChanged: (index) => homepagecontroller.changeVideo(index),
          itemBuilder: (context, index) {
            var post = homepagecontroller.posts[index];
            VideoPlayerController controller =
                homepagecontroller.controllers[index];

            return Stack(
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    controller.value.isPlaying
                        ? controller.pause()
                        : controller.play();
                  }),
                  child: Container(
                    color: Colors.black,
                    child: Center(
                      child: controller.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: controller.value.aspectRatio,
                              child: VideoPlayer(controller),
                            )
                          : CircularProgressIndicator(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('@anupsingh',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text(post['title'],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14)),
                      const SizedBox(height: 5),
                      const Row(
                        children: [
                          Icon(Icons.music_note, color: Colors.white, size: 16),
                          SizedBox(width: 5),
                          Text('Original Sound - Artist',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  right: 10,
                  bottom: 100,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://lh3.googleusercontent.com/a/ACg8ocLgVo0Ti2OoPy8bl4pYQYZ4DscV0zIsjOX9w9ixKuipyirkEQ6J=s288-c-no'),
                        radius: 25,
                      ),
                      SizedBox(height: 10),
                      Icon(Icons.favorite, color: Colors.white, size: 30),
                      Text('1.2K', style: TextStyle(color: Colors.white)),
                      SizedBox(height: 10),
                      Icon(Icons.comment, color: Colors.white, size: 30),
                      Text('345', style: TextStyle(color: Colors.white)),
                      SizedBox(height: 10),
                      Icon(Icons.share, color: Colors.white, size: 30),
                      Text('120', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                // Positioned(
                //   bottom: 0,
                //   left: 0,
                //   right: 0,
                //   child:
                // ),
              ],
            );
          },
        );
      },
    ));
  }
}
