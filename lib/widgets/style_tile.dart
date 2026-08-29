import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import 'room_art.dart';

/// A curated "vibe" tile: code-drawn room art, a scrim, an evocative name, and
/// a selected state with an accent ring + check.
class StyleTile extends StatelessWidget {
  const StyleTile({
    super.key,
    required this.name,
    this.selected = false,
    this.onTap,
    this.aspectRatio = 1.0,
    this.showFurniture = true,
  });

  final String name;
  final bool selected;
  final VoidCallback? onTap;
  final double aspectRatio;
  final bool showFurniture;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        curve: AppDurations.easeOut,
        decoration: BoxDecoration(
          borderRadius: AppRadii.all(AppRadii.md),
          boxShadow: AppShadows.soft,
          border: Border.all(
            color: selected ? AppColors.terracotta : Colors.transparent,
            width: 2.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: AppRadii.all(AppRadii.md - 2),
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: Stack(
              fit: StackFit.expand,
              children: [
                RoomArt(styleName: name, showFurniture: showFurniture),
                const DecoratedBox(
                  decoration: BoxDecoration(gradient: AppGradients.bottomScrim),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      name,
                      style: AppTypography.bodyStrong(AppColors.white),
                    ),
                  ),
                ),
                if (selected)
                  Positioned(
                    top: AppSpacing.sm,
                    right: AppSpacing.sm,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: AppColors.terracotta,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check,
                          size: 15, color: AppColors.white),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
