import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// My dart files
import 'ConfirmPicture.dart';

late List<CameraDescription> _cameras;

Future<void> InitialiseCamera() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
}

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp(this.title, {Key? key}) : super(key: key);

  final String title;

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

  //Handling Flash State
  var flashState = Icons.flash_off;

  void changeFlashState() {
    setState(() {
      if (flashState == Icons.flash_off) {
        flashState = Icons.flash_auto;
      } else {
        if (flashState == Icons.flash_auto) {
          flashState = Icons.flash_on;
        } else {
          flashState = Icons.flash_off;
        }
      }
    });
  } //Handling Flash State



  // Selecting Image from Phone
  Future<void> pickImage() async {


    var picker;
    picker = ImagePicker();
    var imageFile = null;
    imageFile = await picker.pickImage(source: ImageSource.gallery);

    var image = null;
    image = File(imageFile!.path);



    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => displayPicture(image, "gallery", widget.title),
      ),
    );
  } //pickImage

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    // var camera = controller.value;
    // // fetch screen size
    // final size = MediaQuery.of(context).size;
    //
    // // calculate scale depending on screen and camera ratios
    // // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // // because camera preview size is received as landscape
    // // but we're calculating for portrait orientation
    // var scale = size.aspectRatio * camera.aspectRatio;
    //
    // // to prevent scaling down, invert the value
    // if (scale < 1) scale = 1 / scale;

    return Scaffold(
      extendBody: true,
      body: Stack(children: [
        CameraPreview(controller),
        Padding(
          padding: const EdgeInsets.only(bottom: 150.0),
          child: Center(
            child: Container(
              color: Colors.transparent,
              height: 300,
              width: 300,
              child: CustomPaint(
                foregroundPainter: cameraOverlay(),
              ),
            ),
          ),
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height * 1 / 5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 100,
              width: 100,
              child: IconButton(
                onPressed: () {
                  pickImage();
                },
                icon: Icon(
                  Icons.image,
                  size: 32,
                ),
              ),
              //color: Colors.red,
            ),
            Container(
              height: 100,
              width: 100,
              //color: Colors.blue,
              child: IconButton(
                onPressed: () async {

                  if (!controller.value.isInitialized){
                    return null;
                  }

                  if (controller.value.isTakingPicture){
                    return null;
                  }

                  try {
                    if (flashState == Icons.flash_off) {
                      controller.setFlashMode(FlashMode.off);
                    } else {
                      if (flashState == Icons.flash_auto) {
                        controller.setFlashMode(FlashMode.auto);
                      } else {
                        controller.setFlashMode(FlashMode.always);
                      }
                    }
                    //await controller.setFlashMode(FlashMode.auto);
                    XFile picture = await controller.takePicture();
                    var image = File(picture.path);
                    print(image);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => displayPicture(image, "camera", widget.title),
                      ),
                    );
                  } on CameraException catch (e){
                    debugPrint("Error while taking picture : $e");
                    return null;
                  }

                },
                icon: Icon(
                  Icons.circle_outlined,
                  size: 84,
                ),
              ),
            ),
            Container(
              height: 100,
              width: 100,
              //color: Colors.yellow,
              child: IconButton(
                onPressed: () {
                  changeFlashState();
                },
                icon: Icon(
                  flashState,
                  size: 32,
                ),
              ),
            )
          ],
        ),
      ),

      // bottomNavigationBar: BottomAppBar(
      //   height: MediaQuery.of(context).size.height * 1/5,
      //
      //   child: Row(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       IconButton(
      //         onPressed: () {},
      //         icon: Icon(Icons.image),
      //       ),
      //       IconButton(
      //         onPressed: () {},
      //         icon: Icon(Icons.circle_outlined),
      //       ),
      //       IconButton(
      //         onPressed: () {},
      //         icon: Icon(Icons.flash_off),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class cameraOverlay extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color.fromRGBO(255, 255, 255, 0.6)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final topLeft = Path();
    // topLeft.moveTo(size.width * 0, size.height * 2 / 8);
    // topLeft.arcToPoint(Offset(size.width * 2 / 8, size.height * 0),
    //     radius: Radius.circular(70));

    final topRight = Path();
    // topRight.moveTo(size.width * 6 / 8, size.height * 0);
    // topRight.arcToPoint(Offset(size.width * 1, size.height * 2 / 8),
    //     radius: Radius.circular(70));

    final bottomLeft = Path();
    // bottomLeft.moveTo(size.width * 0, size.height * 2 / 3);
    // bottomLeft.arcToPoint(Offset(size.width * 1 / 3, size.height * 1),
    //     radius: Radius.circular(-90), clockwise: false);

    final bottomRight = Path();
    // bottomRight.moveTo(size.width * 2 / 3, size.height * 1);
    // bottomRight.arcToPoint(Offset(size.width * 1, size.height * 2 / 3),
    //     radius: Radius.circular(-90), clockwise: false);
    //

    topLeft.addPolygon([
      Offset(size.width * 0, size.height * 2 / 8),
      Offset(size.width * 0, size.height * 0),
      Offset(size.width * 2 / 8, size.height * 0),
    ], false);

    topRight.addPolygon([
      Offset(size.width * 6 / 8, size.height * 0),
      Offset(size.width * 1, size.height * 0),
      Offset(size.width * 1, size.height * 2 / 8),
    ], false);

    bottomLeft.addPolygon([
      Offset(size.width * 0, size.height * 6 / 8),
      Offset(size.width * 0, size.height * 1),
      Offset(size.width * 2 / 8, size.height * 1),
    ], false);

    bottomRight.addPolygon([
      Offset(size.width * 6 / 8, size.height * 1),
      Offset(size.width * 1, size.height * 1),
      Offset(size.width * 1, size.height * 6 / 8),
    ], false);

    canvas.drawPath(topLeft, paint);
    canvas.drawPath(topRight, paint);
    canvas.drawPath(bottomLeft, paint);
    canvas.drawPath(bottomRight, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
