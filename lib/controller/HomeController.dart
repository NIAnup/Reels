import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels/screen/homepagevideoplayer.dart';
import 'package:reels/screen/addpost/newpost.dart';
import 'package:reels/screen/message/messaage.dart';
import 'package:reels/screen/profile/Profilepage.dart';
import 'package:reels/screen/search/searchpage.dart';

class HomeController extends GetxController {
  RxInt _currentIndex = 0.obs;
  List<Widget> _pages = [
    TikTokHomePage(),
    Searchpage(),
    NewPostScreen(),
    Messaage(),
    Profilepage()
  ];

  int get currentIndex => _currentIndex.value;

  set currentIndex(int index) {
    _currentIndex.value = index;
    update();
  }

  List<Widget> get pages => _pages;
}
