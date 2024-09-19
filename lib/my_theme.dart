import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp_project/appcolors.dart';

class MyTheme {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: Appcolors.primaryColor,
      scaffoldBackgroundColor: Appcolors.backgroundLightColor,
      appBarTheme: AppBarTheme(
        backgroundColor: Appcolors.primaryColor,
        elevation: 0,
      ),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(color: Appcolors.primaryColor, width: 4))),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Appcolors.primaryColor,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(

          ///shape:StadiumBorder(  ///by deafult mdwr
          ///side: BorderSide(
          ///    color: Appcolors.whiteColor,
          ///      width:6

          backgroundColor: Appcolors.primaryColor,
          shape: RoundedRectangleBorder(

              ///bt3ml board white msln 7waleen el icon
              borderRadius: BorderRadius.circular(35),

              /// control fe 4kl el dayra ya3ny lw 2llt 7yb2a rectangle 34an hwa 2sln mwdr
              side: BorderSide(color: Appcolors.whiteColor, width: 6

                  ///7gm el lon gowa
                  ))),
      textTheme: TextTheme(
          bodyLarge: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Appcolors.whiteColor,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Appcolors.blackDarkColor,
          )));

  ///..
  static final ThemeData darkTheme = ThemeData(
    primaryColor: Appcolors.primaryColor,
    scaffoldBackgroundColor: Appcolors.backgroundDarkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Appcolors.primaryColor,
      elevation: 0,
    ),
    textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Appcolors.blackDarkColor,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Appcolors.blackDarkColor,
        )),
    bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
  );
}
