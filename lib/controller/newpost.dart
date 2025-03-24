import 'package:get/get.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reels/widget/customTextfield.dart';
import 'package:reels/widget/custombutton.dart';
import 'package:path/path.dart' as path;
import 'package:video_player/video_player.dart';

class NewPostController extends GetxController {
  final _picker = ImagePicker();
  final RxBool _isUploading = false.obs;
  File? videoFile;
  final Rx<VideoPlayerController?> videoController = null.obs;
  final TextEditingController _titleController = TextEditingController();

  /// Get the current title from textfield
  TextEditingController get title => _titleController;

  bool get isUploading => _isUploading.value;

  /// Select a video from the gallery
  Future<void> pickVideo() async {
    final XFile? pickedFile =
        await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      videoFile = File(pickedFile.path);
      videoController.value = VideoPlayerController.file(videoFile!)
        ..initialize().then((_) {
          videoController.value!.play();
        });
    }
  }

  /// Upload the selected video to Firebase Storage
  Future<void> uploadVideo() async {
    if (videoFile == null || _titleController.text.isEmpty) {
      Get.snackbar("Error", "Please select a video and enter a title");
      return;
    }
    _isUploading.value = true;
    try {
      // Upload video to Firebase Storage
      String fileName = path.basename(videoFile!.path!);
      Reference ref = FirebaseStorage.instance.ref().child("videos/$fileName");
      UploadTask uploadTask = ref.putFile(videoFile!);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save title & video URL to Firestore
      await FirebaseFirestore.instance.collection("posts").add({
        "title": _titleController.text,
        "videoUrl": downloadUrl,
        "timestamp": FieldValue.serverTimestamp(),
      });

      videoFile = null;
      videoController.value?.dispose();
      _isUploading.value = false;
    } catch (e) {
      print("Error uploading video: $e");
      _isUploading.value = false;
    }
  }

  @override
  void onClose() {
    videoController.value?.dispose();
    _titleController.dispose();
    super.onClose();
  }
}
