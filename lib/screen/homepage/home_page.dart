import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reels/controller/HomeController.dart';
import 'package:reels/screen/homepagevideoplayer.dart';
import 'package:reels/screen/addpost/newpost.dart';
import 'package:reels/screen/message/messaage.dart';
import 'package:reels/screen/profile/Profilepage.dart';
import 'package:reels/screen/search/searchpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.currentIndex,
        // onTap: (index) => setState(() => _currentIndex = index),
        onTap: (index) => setState(() => controller.currentIndex = index),
        backgroundColor: Colors.black,
        selectedItemColor: Color(0xFFFA4768),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box, size: 35), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: controller.pages[controller.currentIndex],
    );
  }
}
