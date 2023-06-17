import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/textstyle.dart';

class NotifyPage extends StatelessWidget {
  final String? label;
  final String? additionalLabel;
  const NotifyPage(
      {Key? key, required this.label, required this.additionalLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification',
            style: TextStyle(color: Colors.black, fontSize: 25)),
        backgroundColor: const Color.fromARGB(255, 26, 142, 136),
        centerTitle: true,
        flexibleSpace: Container(
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsetsDirectional.fromSTEB(60, 50, 60, 25),
          padding: const EdgeInsets.all(60.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 222, 240, 224),
              Color.fromARGB(255, 222, 240, 224)
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        toolbarHeight: 100,
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 31, 107, 87),
              Color.fromARGB(255, 123, 214, 208),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  this.label.toString().split("|")[1],
                  style: titleStyles,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
