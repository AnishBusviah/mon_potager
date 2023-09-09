import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_potager/widgets/TextToSpeech.dart';

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
        speak("Flash set to Auto");
      } else {
        if (flashState == Icons.flash_auto) {
          flashState = Icons.flash_on;
          speak("Flash is On");
        } else {
          flashState = Icons.flash_off;
          speak("Flash is off");
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

  bool spokenGallery = false;
  bool spokenFlash = false;
  bool spokenShutter = false;

  Offset? _focusPoint;

  void setFalse() {
    spokenFlash = false;
    spokenGallery = false;
    spokenShutter = false;
  }


  Future<void> _setFocusPoint(Offset point) async{
    if(controller != null && controller.value.isInitialized){

      try{
        final double x = point.dx.clamp(0.0, 1.0);
        final double y = point.dy.clamp(0.0, 1.0);
        await controller.setFocusPoint(Offset(x, y));
        await controller.setFocusMode(FocusMode.auto);
        setState(() {
          _focusPoint = Offset(x, y);
        });

        //Reset focus point after a short delay to remove the square
        await Future.delayed(Duration(seconds: 2));
        setState(() {
          _focusPoint = null;
        });
      }catch (e){
        
        print("Failed to set focus: $e");
      }
    }
  }

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
      body: Stack(children:<Widget> [
        GestureDetector(onTapDown: (TapDownDetails details){
          // speak("hi");
          final Offset tapPosition = details.localPosition;
          final Offset relativeTapPosition = Offset(
            tapPosition.dx/MediaQuery.of(context).size.width,
            tapPosition.dy/ (MediaQuery.of(context).size.width * controller.value.aspectRatio),
          );

          _setFocusPoint(relativeTapPosition);
        } ,child: CameraPreview(controller)),

        GestureDetector(onTapDown: (TapDownDetails details){
          // speak("//hi");
          final Offset tapPosition = details.localPosition;
          final Offset relativeTapPosition = Offset(
            tapPosition.dx/MediaQuery.of(context).size.width,
            tapPosition.dy/ (MediaQuery.of(context).size.width * controller.value.aspectRatio),
          );

          _setFocusPoint(relativeTapPosition);
        } ,child: Padding(
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
        ),),



        if(_focusPoint != null)
          Positioned.fill(top:50, child: Align(alignment: Alignment(_focusPoint!.dx * 2 -1, _focusPoint!.dy * 2 -1,),
          child: Container(
            height: 80,
              width: 80,
            decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 2)),
          ),),)

      ]),
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height * 1 / 5,
        child: Listener(
          onPointerMove: (PointerMoveEvent event) {
            print("${event.position.dx}, ${event.position.dy}");
            if ((event.position.dx >= 80 && event.position.dx <= 100) &&
                (event.position.dy >= 710 && event.position.dy <= 712)) {
              if (!spokenGallery) {
                speak("Click to Open gallery");
                setState(() {
                  setFalse();
                  spokenGallery = true;
                });
              }
            } else if ((event.position.dx >= 170 && event.position.dx <= 249) &&
                (event.position.dy >= 679 && event.position.dy <= 767)) {
              if (!spokenShutter) {
                speak("Click to take picture");
                setState(() {
                  setFalse();
                  spokenShutter = true;
                });
              }
            } else if ((event.position.dx >= 302 && event.position.dx <= 372) &&
                (event.position.dy >= 712 && event.position.dy <= 753)) {
              if (!spokenFlash) {
                speak("Click to change flash state");
                setState(() {
                  setFalse();
                  spokenFlash = true;
                });
              }
            } else {
              setState(() {
                setFalse();
              });
            }
          },
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
                    speak("Picture Taken");
                    if (!controller.value.isInitialized) {
                      return null;
                    }

                    if (controller.value.isTakingPicture) {
                      return null;
                    }

                    try {
                      if (flashState == Icons.flash_off) {
                        controller.setFlashMode(FlashMode.off);
                        // speak("Flash Off");
                        // print("speak(Flash Off);");
                      } else {
                        if (flashState == Icons.flash_auto) {
                          controller.setFlashMode(FlashMode.auto);
                          // speak("Flash set to Auto");
                          // print("speak(Flash set to Auto);");
                        } else {
                          controller.setFlashMode(FlashMode.always);
                          // speak("Flash On");
                          // print("speak(Flash On);");
                        }
                      }
                      //await controller.setFlashMode(FlashMode.auto);
                      XFile picture = await controller.takePicture();
                      var image = File(picture.path);
                      print(image);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              displayPicture(image, "camera", widget.title),
                        ),
                      );
                    } on CameraException catch (e) {
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
