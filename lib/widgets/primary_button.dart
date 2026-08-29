import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';

/// The signature Lumo call-to-action: a gradient pill with a soft accent glow
/// and a satisfying spring press animation.
class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = true,
    this.enabled = true,
    this.gradient,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;
  final bool enabled;
  final Gradient? gradient;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.enabled && widget.onPressed != null;
    return GestureDetector(
      onTapDown: enabled ? (_) => setState(() => _down = true) : null,
      onTapCancel: enabled ? () => setState(() => _down = false) : null,
      onTapUp: enabled
          ? (_) {
              setState(() => _down = false);
              widget.onPressed!();
            }
          : null,
      child: AnimatedScale(
        scale: _down ? 0.96 : 1.0,
        duration: AppDurations.fast,
        curve: AppDurations.easeOut,
        child: AnimatedOpacity(
          opacity: enabled ? 1 : 0.45,
          duration: AppDurations.fast,
          child: Container(
            width: widget.expand ? double.infinity : null,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: 18,
            ),
            decoration: BoxDecoration(
              gradient: widget.gradient ?? AppGradients.accent,
              borderRadius: AppRadii.all(AppRadii.pill),
              boxShadow: enabled ? AppShadows.accentGlow : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, color: AppColors.white, size: 20),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Text(widget.label, style: AppTypography.button(AppColors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A quieter secondary button — outlined pill that adapts to theme.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: expand ? const Size.fromHeight(56) : null,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.all(AppRadii.pill),
          side: BorderSide(color: context.c.outline, width: 1.4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      ),
      child: Text(label, style: AppTypography.button(context.c.onBackground)),
    );
  }
}
