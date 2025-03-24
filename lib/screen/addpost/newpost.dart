import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reels/widget/customTextfield.dart';
import 'package:reels/widget/custombutton.dart';
import 'package:path/path.dart' as path;
import 'package:video_player/video_player.dart';

import '../../controller/newpost.dart';

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final NewPostController newPostController = Get.put(NewPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Post")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video Preview
              newPostController.videoFile == null
                  ? InkWell(
                      onTap: newPostController.pickVideo,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(color: Colors.grey, width: 2.0),
                        ),
                        child: Center(child: Text("Select Video")),
                      ),
                    )
                  : AspectRatio(
                      aspectRatio: newPostController
                              .videoController?.value?.value.aspectRatio ??
                          16 / 9,
                      child: newPostController.videoController.value != null &&
                              newPostController
                                  .videoController.value!.value.isInitialized
                          ? VideoPlayer(
                              newPostController.videoController.value!)
                          : Center(child: CircularProgressIndicator()),
                    ),

              SizedBox(height: 10),

              // Title Input
              Customtextfield(
                controller: newPostController.title,
                hintText: "Title",
              ),

              SizedBox(height: 10),

              // Upload Button
              newPostController.isUploading
                  ? LinearProgressIndicator()
                  : Center(
                      child: Custombutton(
                        height: 50,
                        onTap: newPostController.uploadVideo,
                        text: "Upload Video",
                      ),
                    ),

              SizedBox(height: 10),

              // Reset to Select Video
              // _videoFile == null && !_isUploading
              //     ? InkWell(
              //         onTap: _pickVideo,
              //         child: Container(
              //           height: 200,
              //           decoration: BoxDecoration(
              //             color: Colors.grey[300],
              //             border: Border.all(color: Colors.grey, width: 2.0),
              //           ),
              //           child: Center(child: Text("Select Video")),
              //         ),
              //       )
              //     : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
