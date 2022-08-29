import 'package:applocation/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleApp {
  StyleApp._();

  static TextStyle caption = GoogleFonts.openSans(
    fontSize: 27,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 1.33,
    color: ConstColors.orange
  );

  static TextStyle titleLarge = GoogleFonts.openSans(
    fontSize: 55,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    height: 1.40,
    color: ConstColors.orange
  );

  static TextStyle paragraphMdRegular = GoogleFonts.openSans(
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 1.33,
    color: ConstColors.orange
  );
}
