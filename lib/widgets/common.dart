import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';

/// A soft, rounded surface card with the Lumo diffuse shadow.
class SoftCard extends StatelessWidget {
  const SoftCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.radius = AppRadii.lg,
    this.color,
    this.onTap,
  });

  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? context.c.surface,
      borderRadius: AppRadii.all(radius),
      child: InkWell(
        borderRadius: AppRadii.all(radius),
        onTap: onTap,
        child: Ink(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: AppRadii.all(radius),
            boxShadow: AppShadows.soft,
          ),
          child: child,
        ),
      ),
    );
  }
}

/// A frosted-glass card — real backdrop blur, used over rich backgrounds.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.radius = AppRadii.lg,
    this.tint,
  });

  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadii.all(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: (tint ?? Colors.white).withOpacity(0.16),
            borderRadius: AppRadii.all(radius),
            border: Border.all(color: Colors.white.withOpacity(0.22)),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// An eyebrow + heading pair used at the top of sections.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.eyebrow,
    this.subtitle,
    this.center = false,
    this.onLight = false,
  });

  final String title;
  final String? eyebrow;
  final String? subtitle;
  final bool center;

  /// When true, forces light-on-dark colors (for use over hero art).
  final bool onLight;

  @override
  Widget build(BuildContext context) {
    final primary = onLight ? AppColors.boneOnDark : context.c.onBackground;
    final secondary =
        onLight ? AppColors.mochaOnDark : context.c.secondaryText;
    final align = center ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    return Column(
      crossAxisAlignment: align,
      children: [
        if (eyebrow != null) ...[
          Text(
            eyebrow!.toUpperCase(),
            textAlign: center ? TextAlign.center : TextAlign.start,
            style: AppTypography.overline(AppColors.terracotta),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        Text(
          title,
          textAlign: center ? TextAlign.center : TextAlign.start,
          style: AppTypography.headline(primary),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            subtitle!,
            textAlign: center ? TextAlign.center : TextAlign.start,
            style: AppTypography.body(secondary),
          ),
        ],
      ],
    );
  }
}

/// A shimmering skeleton block for premium loading states.
class ShimmerBox extends StatefulWidget {
  const ShimmerBox({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.radius = AppRadii.sm,
  });

  final double width;
  final double height;
  final double radius;

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = context.c.outline.withOpacity(0.4);
    final hi = context.c.surface;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: AppRadii.all(widget.radius),
            gradient: LinearGradient(
              begin: Alignment(-1 - 2 * _ctrl.value, 0),
              end: Alignment(1 - 2 * _ctrl.value, 0),
              colors: [base, hi, base],
              stops: const [0.35, 0.5, 0.65],
            ),
          ),
        );
      },
    );
  }
}

/// A small pill chip (used for tags, "Pro", credits, etc.).
class Pill extends StatelessWidget {
  const Pill({
    super.key,
    required this.label,
    this.gradient,
    this.color,
    this.textColor,
    this.icon,
  });

  final String label;
  final Gradient? gradient;
  final Color? color;
  final Color? textColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final fg = textColor ?? AppColors.white;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: gradient,
        color: color,
        borderRadius: AppRadii.all(AppRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: fg),
            const SizedBox(width: 5),
          ],
          Text(label, style: AppTypography.overline(fg)),
        ],
      ),
    );
  }
}
