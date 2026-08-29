import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import 'room_art.dart';

/// A draggable before/after reveal. The "before" is an empty/plain room; the
/// "after" is the styled room. Dragging the handle wipes between them — the
/// signature interaction from the best apps in the category.
class BeforeAfterSlider extends StatefulWidget {
  const BeforeAfterSlider({
    super.key,
    required this.styleName,
    this.beforeStyleName = 'Luxe Minimalism',
    this.borderRadius = AppRadii.lg,
    this.showLabels = true,
  });

  final String styleName;
  final String beforeStyleName;
  final double borderRadius;
  final bool showLabels;

  @override
  State<BeforeAfterSlider> createState() => _BeforeAfterSliderState();
}

class _BeforeAfterSliderState extends State<BeforeAfterSlider> {
  double _pos = 0.5;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return ClipRRect(
          borderRadius: AppRadii.all(widget.borderRadius),
          child: GestureDetector(
            onHorizontalDragUpdate: (d) {
              setState(() {
                _pos = (_pos + d.delta.dx / width).clamp(0.0, 1.0);
              });
            },
            onTapDown: (d) {
              setState(() => _pos = (d.localPosition.dx / width).clamp(0, 1));
            },
            child: Stack(
              children: [
                // AFTER (full, styled room) underneath.
                Positioned.fill(
                  child: RoomArt(styleName: widget.styleName),
                ),
                // BEFORE clipped to the left of the handle.
                Positioned.fill(
                  child: ClipRect(
                    clipper: _RevealClipper(_pos),
                    child: RoomArt(
                      styleName: widget.beforeStyleName,
                      showFurniture: false,
                    ),
                  ),
                ),
                if (widget.showLabels) ...[
                  _label('BEFORE', Alignment.topLeft),
                  _label('AFTER', Alignment.topRight),
                ],
                // Handle.
                Positioned(
                  left: _pos * width - 1,
                  top: 0,
                  bottom: 0,
                  child: _Handle(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _label(String text, Alignment align) {
    return Align(
      alignment: align,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.espresso.withOpacity(0.55),
            borderRadius: AppRadii.all(AppRadii.pill),
          ),
          child: Text(text, style: AppTypography.overline(AppColors.white)),
        ),
      ),
    );
  }
}

class _Handle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 2, color: AppColors.white.withOpacity(0.9)),
        Transform.translate(
          offset: const Offset(-19, 0),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: AppShadows.lifted,
              ),
              child: const Icon(
                Icons.unfold_more,
                color: AppColors.espresso,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RevealClipper extends CustomClipper<Rect> {
  _RevealClipper(this.fraction);
  final double fraction;

  @override
  Rect getClip(Size size) =>
      Rect.fromLTWH(0, 0, size.width * fraction, size.height);

  @override
  bool shouldReclip(covariant _RevealClipper old) => old.fraction != fraction;
}
