import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// Design tokens for spacing, radii, shadows and durations. Kept in one place
/// so the whole app breathes with the same rhythm.
class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double page = 24; // default horizontal page padding
}

class AppRadii {
  AppRadii._();
  static const double sm = 12;
  static const double md = 18;
  static const double lg = 26;
  static const double xl = 34;
  static const double pill = 100;

  static BorderRadius all(double r) => BorderRadius.circular(r);
}

class AppShadows {
  AppShadows._();

  /// Soft, low, warm shadow — never harsh. This is a big part of the premium
  /// feel: diffuse elevation rather than crisp drop shadows.
  static List<BoxShadow> soft = [
    BoxShadow(
      color: AppColors.espresso.withOpacity(0.06),
      blurRadius: 24,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: AppColors.espresso.withOpacity(0.04),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> lifted = [
    BoxShadow(
      color: AppColors.espresso.withOpacity(0.12),
      blurRadius: 40,
      offset: const Offset(0, 18),
    ),
  ];

  static List<BoxShadow> accentGlow = [
    BoxShadow(
      color: AppColors.terracotta.withOpacity(0.32),
      blurRadius: 28,
      offset: const Offset(0, 12),
    ),
  ];
}

class AppDurations {
  AppDurations._();
  static const Duration fast = Duration(milliseconds: 220);
  static const Duration base = Duration(milliseconds: 420);
  static const Duration slow = Duration(milliseconds: 700);
  static const Curve easeOut = Curves.easeOutCubic;
  static const Curve spring = Curves.easeOutBack;
}

/// Builds the light and dark [ThemeData] for Lumo.
class AppTheme {
  AppTheme._();

  static ThemeData light() => _base(
        brightness: Brightness.light,
        background: AppColors.bone,
        surface: AppColors.linen,
        onBackground: AppColors.espresso,
        onSurfaceSecondary: AppColors.mocha,
        outline: AppColors.sand,
      );

  static ThemeData dark() => _base(
        brightness: Brightness.dark,
        background: AppColors.night,
        surface: AppColors.charcoal,
        onBackground: AppColors.boneOnDark,
        onSurfaceSecondary: AppColors.mochaOnDark,
        outline: AppColors.graphite,
      );

  static ThemeData _base({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color onBackground,
    required Color onSurfaceSecondary,
    required Color outline,
  }) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.terracotta,
      onPrimary: AppColors.white,
      secondary: AppColors.gold,
      onSecondary: AppColors.espresso,
      surface: surface,
      onSurface: onBackground,
      error: AppColors.error,
      onError: AppColors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: background,
      colorScheme: scheme,
      splashFactory: InkRipple.splashFactory,
      textTheme: TextTheme(
        displayLarge: AppTypography.display(onBackground),
        headlineMedium: AppTypography.headline(onBackground),
        titleLarge: AppTypography.title(onBackground),
        bodyLarge: AppTypography.body(onBackground),
        bodyMedium: AppTypography.body(onSurfaceSecondary),
        labelLarge: AppTypography.label(onSurfaceSecondary),
      ),
      // Custom tokens surfaced via extension for easy access in widgets.
      extensions: [
        AppColorsExt(
          background: background,
          surface: surface,
          onBackground: onBackground,
          secondaryText: onSurfaceSecondary,
          outline: outline,
        ),
      ],
    );
  }
}

/// A theme extension so widgets can read semantic colors that adapt to
/// light/dark without hard-coding.
@immutable
class AppColorsExt extends ThemeExtension<AppColorsExt> {
  const AppColorsExt({
    required this.background,
    required this.surface,
    required this.onBackground,
    required this.secondaryText,
    required this.outline,
  });

  final Color background;
  final Color surface;
  final Color onBackground;
  final Color secondaryText;
  final Color outline;

  @override
  AppColorsExt copyWith({
    Color? background,
    Color? surface,
    Color? onBackground,
    Color? secondaryText,
    Color? outline,
  }) {
    return AppColorsExt(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      onBackground: onBackground ?? this.onBackground,
      secondaryText: secondaryText ?? this.secondaryText,
      outline: outline ?? this.outline,
    );
  }

  @override
  AppColorsExt lerp(AppColorsExt? other, double t) {
    if (other == null) return this;
    return AppColorsExt(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
    );
  }
}

/// Convenience accessor: `context.c` gives the semantic colors.
extension AppThemeContext on BuildContext {
  AppColorsExt get c => Theme.of(this).extension<AppColorsExt>()!;
}
