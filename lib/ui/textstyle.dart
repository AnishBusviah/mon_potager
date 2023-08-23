import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get subHeadingStyles {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 189, 189, 189),
      ));
}

TextStyle get headingStyles {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ));
}

TextStyle get titleStyles {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ));
}

TextStyle get subTitleStyles {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey));
}
