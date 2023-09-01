import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import './CameraCode.dart';
import '../Camera.dart';




// class StartCamera extends StatefulWidget {
//   const StartCamera({Key? key}) : super(key: key);
//
//   @override
//   State<StartCamera> createState() => _StartCameraState();
// }
//
// class _StartCameraState extends State<StartCamera> {
//   var flashIconState = Icons.flash_off;
//
//   void toggleFlash() {
//     setState(
//       () {
//         if (flashIconState == Icons.flash_off) {
//           flashIconState = Icons.flash_on;
//         } else {
//           flashIconState = Icons.flash_off;
//         }
//       },
//     );
//   } //toggleFlash
//
//   Future<void> pickImage() async {
//     final picker = ImagePicker();
//     final imageFile = await picker.pickImage(source: ImageSource.gallery);
//   } //pickImage
//
//   Future<void> takeImage() async {
//
//     print("ok");
//     CameraAppState CameraState = new CameraAppState();
//     XFile imageFile = await CameraState.controller.takePicture();
//
//     var image = File(imageFile.path);
//     print("ok");
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => displayPicture(image)),
//     );
//   } //pickImage
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: const Text('Identify Plant'),
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: const CameraApp(),
//           ),
//           Center(
//             child: Container(
//               color: Colors.transparent,
//               height: 300,
//               width: 300,
//               child: CustomPaint(
//                 foregroundPainter: cameraOverlay(),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         height: 150,
//         child: Center(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                 height: 100,
//                 width: 100,
//                 child: IconButton(
//                   onPressed: pickImage,
//                   icon: Icon(
//                     Icons.image,
//                     size: 32,
//                   ),
//                 ),
//                 //color: Colors.red,
//               ),
//               Container(
//                 height: 100,
//                 width: 100,
//                 //color: Colors.blue,
//                 child: IconButton(
//                   onPressed: takeImage,
//                   icon: Icon(
//                     Icons.circle_outlined,
//                     size: 84,
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 100,
//                 width: 100,
//                 //color: Colors.yellow,
//                 child: IconButton(
//                   onPressed: () {
//                     toggleFlash();
//                   },
//                   icon: Icon(
//                     flashIconState,
//                     size: 32,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class AddNotePhoto extends StatelessWidget {
  const AddNotePhoto(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(child: CameraApp(title),),
    );
    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   appBar: AppBar(
    //     title: const Text('Identify Plant'),
    //     backgroundColor: Colors.transparent,
    //     elevation: 0.0,
    //   ),
    //
    //   // bottomNavigationBar: Container(
    //   //   height: 150,
    //   //   child: Center(
    //   //     child: Row(
    //   //       crossAxisAlignment: CrossAxisAlignment.center,
    //   //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   //       children: [
    //   //         Container(
    //   //           height: 100,
    //   //           width: 100,
    //   //           child: IconButton(
    //   //             onPressed: () {},
    //   //             icon: Icon(
    //   //               Icons.browse_gallery_outlined,
    //   //               size: 32,
    //   //             ),
    //   //           ),
    //   //           //color: Colors.red,
    //   //         ),
    //   //         Container(
    //   //           height: 100,
    //   //           width: 100,
    //   //           //color: Colors.blue,
    //   //           child: IconButton(
    //   //             onPressed: () {},
    //   //             icon: Icon(
    //   //               Icons.circle_outlined,
    //   //               size: 84,
    //   //             ),
    //   //           ),
    //   //         ),
    //   //         Container(
    //   //           height: 100,
    //   //           width: 100,
    //   //           //color: Colors.yellow,
    //   //           child: IconButton(
    //   //             onPressed: () {},
    //   //             icon: Icon(
    //   //                Icons.flash_off,
    //   //               size: 32,
    //   //             ),
    //   //           ),
    //   //         )
    //   //       ],
    //   //     ),
    //   //   ),
    //   // ),
    // );
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
