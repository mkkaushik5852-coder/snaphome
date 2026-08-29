import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Curated gradients used across Lumo.
///
/// Since we render everything in code (no bundled photos), these gradients
/// double as our "room imagery" — each curated style has its own evocative
/// gradient so the app still feels rich and art-directed.
class AppGradients {
  AppGradients._();

  /// Warm brand gradient for primary CTAs.
  static const LinearGradient accent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.terracotta, AppColors.terracottaDeep],
  );

  /// Subtle gold sheen for premium / Pro badges.
  static const LinearGradient gold = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.goldSoft, AppColors.gold],
  );

  /// Soft page wash for light backgrounds (very low contrast mesh feel).
  static const LinearGradient lightWash = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.bone, AppColors.linen],
  );

  static const LinearGradient darkWash = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.night, AppColors.charcoal],
  );

  /// A scrim used over hero art so text stays legible.
  static const LinearGradient bottomScrim = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0xCC16120E)],
    stops: [0.35, 1.0],
  );

  /// Named "style vibe" gradients — one per curated interior style.
  /// These are the placeholder art for style tiles and rendered rooms.
  /// Each is a warm, art-directed pair evoking that style's mood.
  static const Map<String, List<Color>> vibes = {
    'Soft Mediterranean': [Color(0xFFEDE0C7), Color(0xFFCBB48F)],
    'Walnut Cocoon': [Color(0xFF6B4E36), Color(0xFF3B2A1D)],
    'Midnight Deco Warmth': [Color(0xFF2C2A33), Color(0xFF574236)],
    'Collected Mid-Century': [Color(0xFFD98E5A), Color(0xFF9A5A3C)],
    'Luxe Minimalism': [Color(0xFFF1ECE4), Color(0xFFD7CCBB)],
    'Modern Farmhouse': [Color(0xFFE8E4DB), Color(0xFFAFA692)],
    'Terracotta Adobe': [Color(0xFFD98C63), Color(0xFFB05C36)],
    'Elegant Oxblood': [Color(0xFF7A2E2A), Color(0xFF45211F)],
    'Velvet Emerald': [Color(0xFF2F5D4E), Color(0xFF17322A)],
    'Coastal Linen': [Color(0xFFE4E7E2), Color(0xFFB6C2BC)],
    'Japandi Calm': [Color(0xFFE3DBCD), Color(0xFFBFB09A)],
    'Moody Navy Luxe': [Color(0xFF2A3A4D), Color(0xFF16222F)],
  };

  /// Returns a smooth gradient for a given style name, falling back to a
  /// tasteful neutral if the style is unknown.
  static LinearGradient vibe(String name) {
    final colors = vibes[name] ?? const [AppColors.clay, AppColors.walnut];
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors,
    );
  }
}
