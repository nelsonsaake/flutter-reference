import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semper_web/app_resources/app_colors.dart';
import 'package:semper_web/extensions/color.dart';
import 'package:semper_web/styles/button_styles.dart';

final theme = ThemeData(
  useMaterial3: true,
  primarySwatch: AppColors.green.toMaterial,
  primaryColor: AppColors.green,
  fontFamily: GoogleFonts.nunito().fontFamily,
  textTheme: GoogleFonts.nunitoTextTheme(),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: AppColors.red,
    background: AppColors.cream,
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.green,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.white)),
  dividerTheme: DividerThemeData(
    thickness: 1,
    space: 0,
    color: AppColors.gray.withOpacity(.2),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.green,
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: AppColors.green,
    unselectedLabelColor: AppColors.text,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: AppColors.green,
          width: 2,
        ),
      ),
    ),
  ),
  buttonTheme: ButtonThemeData(
    shape: ButtonStyles.rounded,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: ButtonStyles.rounded,
    ),
  ),
  navigationDrawerTheme: NavigationDrawerThemeData(
    backgroundColor: AppColors.cream,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
      side: BorderSide.none,
    ),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: AppColors.green,
    endShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    shape: CircleBorder(),
    backgroundColor: AppColors.green,
  ),
);
