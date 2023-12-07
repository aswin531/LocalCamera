import 'package:camera/screenone.dart';
import 'package:flutter/material.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>  ScreenOne(),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(219, 158, 158, 158),
      body: Container(
          alignment: Alignment.center,
          child: Image.asset('assets/images/cameralogo.png')),
    );
  }
}
