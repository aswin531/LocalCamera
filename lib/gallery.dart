import 'dart:io';

import 'package:camera/dbhelper.dart';
import 'package:camera/fullscreen.dart';
import 'package:camera/model.dart';
import 'package:camera/screenone.dart';
import 'package:flutter/material.dart';

class GalleryWidget extends StatefulWidget {
  final CameraModel camera;
  const GalleryWidget({super.key, required this.camera});

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    getImage();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const ScreenOne(),
              ));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: ValueListenableBuilder(
        valueListenable: imageListNotifier,
        builder: (context, List<CameraModel> imageList, Widget? child) {
          final filteredImage =
              imageList.where((image) => image.path.isNotEmpty).toList();

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 5.0,
            ),
            itemBuilder: (context, index) {
              final data = filteredImage[index];
              return Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FullScreen(
                        camera: data,
                      ),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 130,
                          child: Image.file(
                            File(data.path),
                          ),
                        ),
                        ListTile(
                          trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Are you sure?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          final deleted =
                                              await deleteById(data.id!);
                                          if (deleted) {
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: const Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('No'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: filteredImage.length,
          );
        },
      ),
    );
  }
}
