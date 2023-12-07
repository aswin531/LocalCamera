import 'dart:io';

import 'package:camera/dbhelper.dart';
import 'package:camera/gallery.dart';
import 'package:camera/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  String? _selectedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final returnFile = await picker.pickImage(source: ImageSource.camera);

    if (returnFile != null) {
      setState(() {
        _selectedImage = returnFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Camera'),
        centerTitle: true,
        // actions: [Icon(Icons.camera_alt_outlined)],
      ),
      body: Container(
        color: Colors.white30,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                  child: _selectedImage != null
                      ? Image.file(File(_selectedImage!))
                      : const Text(
                          'Take a Pic',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      pickImage();
                     
                    },
                    child: const Icon(Icons.camera),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      imagecheck();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => GalleryWidget(
                              camera: CameraModel(path: _selectedImage ?? '')),
                        ));
                    },
                    child: const Icon(Icons.image),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> imagecheck() async {
    final camera = CameraModel(path: _selectedImage ?? '');
    await addImage(camera);
    // await getImage(); 
  }

}
