import 'package:flutter/material.dart';

/// The Lumo color language.
///
/// Editorial / architectural-digest luxury: warm neutrals (bone, sand,
/// espresso) with a single muted-terracotta/gold accent. Every value is
/// hand-tuned so the palette reads as calm, expensive and timeless rather
/// than "techy".
class AppColors {
  AppColors._();

  // ---- Warm neutrals (light) ----
  static const Color bone = Color(0xFFF7F3EC); // page background
  static const Color linen = Color(0xFFEFE8DD); // raised surfaces
  static const Color sand = Color(0xFFE4D9C8); // borders / dividers
  static const Color clay = Color(0xFFD9C9B3);

  // ---- Espresso darks ----
  static const Color espresso = Color(0xFF211B15); // primary text on light
  static const Color cocoa = Color(0xFF3A3027);
  static const Color walnut = Color(0xFF4A3F34);
  static const Color mocha = Color(0xFF6B5D4D); // secondary text
  static const Color stone = Color(0xFF9A8C79); // tertiary text

  // ---- Accent: muted terracotta + warm gold ----
  static const Color terracotta = Color(0xFFC06A4A);
  static const Color terracottaDeep = Color(0xFFA8542F);
  static const Color gold = Color(0xFFC9A24B);
  static const Color goldSoft = Color(0xFFE3C889);

  // ---- Dark mode neutrals ----
  static const Color night = Color(0xFF16120E); // dark page background
  static const Color charcoal = Color(0xFF1F1A15); // dark raised surface
  static const Color graphite = Color(0xFF2A241E); // dark borders
  static const Color boneOnDark = Color(0xFFF3ECE0); // primary text on dark
  static const Color mochaOnDark = Color(0xFFB9AC99); // secondary on dark

  // ---- Universal ----
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Semantic
  static const Color success = Color(0xFF5E8B6A);
  static const Color error = Color(0xFFB4553F);
}
