import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Lumo's type system: an elegant serif display face paired with a clean,
/// highly-legible sans for body and UI. Sizes follow a calm editorial scale.
class AppTypography {
  AppTypography._();

  /// Display / headline face — elegant high-contrast serif.
  static TextStyle display(Color color) => GoogleFonts.playfairDisplay(
        fontSize: 40,
        height: 1.08,
        letterSpacing: -0.5,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle headline(Color color) => GoogleFonts.playfairDisplay(
        fontSize: 28,
        height: 1.15,
        letterSpacing: -0.3,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle title(Color color) => GoogleFonts.playfairDisplay(
        fontSize: 21,
        height: 1.2,
        fontWeight: FontWeight.w600,
        color: color,
      );

  /// Body + UI face — clean sans.
  static TextStyle body(Color color) => GoogleFonts.inter(
        fontSize: 15.5,
        height: 1.5,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle bodyStrong(Color color) => GoogleFonts.inter(
        fontSize: 15.5,
        height: 1.45,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle label(Color color) => GoogleFonts.inter(
        fontSize: 13,
        height: 1.3,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w500,
        color: color,
      );

  /// All-caps eyebrow / overline used above headings.
  static TextStyle overline(Color color) => GoogleFonts.inter(
        fontSize: 11.5,
        height: 1.2,
        letterSpacing: 2.4,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle button(Color color) => GoogleFonts.inter(
        fontSize: 16,
        letterSpacing: 0.3,
        fontWeight: FontWeight.w600,
        color: color,
      );
}
