import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'CameraOverlay.dart';

late List<CameraDescription> _cameras;

Future<void> InitialiseCamera() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
}

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => CameraAppState();
}

class CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      // home: CameraPreview(controller),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Identify Plant"),
        ),
        body:  CameraPreview(controller),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.image),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.circle_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.flash_off),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
