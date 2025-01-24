import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tes2/app/components/mahas_colors.dart';

class MahasThemes {
  static double borderRadius = 5;

  static ThemeData light = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(88, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        backgroundColor: MahasColors.primary,
      ),
    ),
    useMaterial3: false,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: const Size(88, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: MahasColors.primary,
      centerTitle: false,
    ),
  );

  static TextStyle h1 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static InputDecoration? textFiendDecoration({
    hintText,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hintText,
    );
  }

  static TextStyle title = const TextStyle(
    fontWeight: FontWeight.bold,
  );

  static TextStyle muted = TextStyle(
    color: MahasColors.dark.withValues(alpha: .5),
  );

  static TextStyle textLight = const TextStyle(
    color: MahasColors.light,
  );

  static TextStyle link =
      const TextStyle(fontWeight: FontWeight.bold, color: MahasColors.primary);

  static RoundedRectangleBorder cardBorderShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(borderRadius),
  );
}
