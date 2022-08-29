import 'package:applocation/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData1 = ThemeData(
  fontFamily: GoogleFonts.openSans().fontFamily,
  scaffoldBackgroundColor: Colors.grey.shade100,
  primaryColor: ConstColors.orange,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: ConstColors.createMaterialColor(ConstColors.orange),
  ).copyWith(
    secondary: ConstColors.orange,
    primary: ConstColors.orange,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.all(10),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    // //Focus no input sem error
    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2, color: ConstColors.orange)),
    // //Input em modo de bloqueado
    disabledBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 1, color: ConstColors.orange)),
    // //Sem focus, input nao teve evento
    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 1, color: ConstColors.orange)),
    // //Borda global aqui
    border: const UnderlineInputBorder(borderSide: BorderSide(width: 1, color: ConstColors.orange)),
    // //Com error sem evento, ou seja o focus esta em outro input
    errorBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 1, color: ConstColors.orange)),
    // //Com error e o focus no input
    focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 1, color: ConstColors.orange)),
    hintStyle: GoogleFonts.openSans(color: Colors.grey, fontSize: 14),
    helperStyle: GoogleFonts.openSans(color: ConstColors.orange),
    errorStyle: GoogleFonts.openSans(color: ConstColors.orange, fontSize: 14),
    labelStyle: GoogleFonts.openSans(fontSize: 19, fontWeight: FontWeight.w900, color: ConstColors.orange),
    helperMaxLines: 5,
    errorMaxLines: 5,
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.openSans(
      color: ConstColors.orange,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      height: 1.55,
    ),
    titleMedium: GoogleFonts.openSans(
      color: ConstColors.orange,
      fontSize: 17,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      height: 1.33,
    ),

    ///Para todos textos dos botões
    displayMedium: GoogleFonts.openSans(
      color: ConstColors.orange,
      fontSize: 17,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      height: 1.33,
    ),
    // displayLarge:TextStyle(),
    // displayMedium:TextStyle(),
    // displaySmall:TextStyle(),
    // headlineMedium:TextStyle(),
    // headlineSmall:TextStyle(),
    // titleLarge:TextStyle(),
    // titleSmall:TextStyle(),
    // bodyLarge:TextStyle(),
    // bodyMedium:TextStyle(),
    // bodySmall:TextStyle(),
    // labelLarge:TextStyle(),
    // labelSmall:TextStyle(),
  ),
);
