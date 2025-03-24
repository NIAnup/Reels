import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class VideoController extends GetxController {
  final RxList<VideoPlayerController> controllers =
      <VideoPlayerController>[].obs;
  final RxList<Map<String, dynamic>> posts = <Map<String, dynamic>>[].obs;
  final RxInt currentIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxBool isOfflineMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkInternetAndFetchVideos();
  }

  /// Check internet and fetch videos
  Future<void> checkInternetAndFetchVideos() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      isOfflineMode.value = true;
      loadCachedVideos();
    } else {
      isOfflineMode.value = false;
      fetchPosts();
    }
  }

  /// Fetch videos from Firestore
  Future<void> fetchPosts() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('posts').get();
      posts.assignAll(snapshot.docs.map((doc) => {
            'videoUrl': doc['videoUrl'],
            'title': doc['title'],
          }));
      isLoading.value = false;
      initializeControllers();
      prefetchVideos();
    } catch (e) {
      print("Error fetching posts: $e");
    }
  }

  void initializeControllers() {
    controllers.clear();
    for (var post in posts) {
      var controller = VideoPlayerController.network(post['videoUrl']);
      controller.initialize().then((_) {
        controller.setLooping(true);
        // update();
      });
      controllers.add(controller);
    }
  }

  /// Prefetch and cache next 3 videos
  void prefetchVideos() async {
    for (var post in posts.take(3)) {
      String url = post['videoUrl'];
      await cacheVideo(url);
    }
  }

  /// Cache video locally
  Future<void> cacheVideo(String url) async {
    try {
      String fileName = url.split('/').last;
      Directory dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/$fileName');

      if (!await file.exists()) {
        var response = await Dio().download(url, file.path);
        if (response.statusCode == 200) {
          print("Video cached: ${file.path}");
        }
      }
    } catch (e) {
      print("Error caching video: $e");
    }
  }

  /// Load cached videos when offline
  Future<void> loadCachedVideos() async {
    Directory dir = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> files = dir.listSync();
    posts.assignAll(files.map((file) => {
          'videoUrl': file.path,
          'title': 'Cached Video',
        }));

    initializeControllers();
  }

  /// Change video and ensure only one audio is playing
  void changeVideo(int index) {
    if (index < controllers.length) {
      controllers[currentIndex.value].pause();
      currentIndex.value = index;
      controllers[currentIndex.value].play();
      // update();
    }
  }

  @override
  void onClose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
