import 'dart:io';

import 'package:camera/model.dart';
import 'package:flutter/material.dart';

class FullScreen extends StatefulWidget {
  final CameraModel camera;
  const FullScreen({super.key, required this.camera});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Image '),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 500,
            height: 450,
            child: Image.file(File(widget.camera.path)),
          ),
        ],
      ),
    );
  }
}
