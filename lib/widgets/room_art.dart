import 'package:flutter/material.dart';
import '../theme/app_gradients.dart';

/// Draws a stylised, code-only "interior room" scene tinted by a style's
/// gradient. This is our placeholder art in lieu of bundled photos — a soft
/// perspective room with a window, floor, and a couple of furniture
/// silhouettes so tiles and result cards feel like real design imagery.
class RoomArt extends StatelessWidget {
  const RoomArt({
    super.key,
    required this.styleName,
    this.showFurniture = true,
    this.seed = 0,
  });

  final String styleName;
  final bool showFurniture;
  final int seed;

  @override
  Widget build(BuildContext context) {
    final colors = AppGradients.vibes[styleName] ??
        const [Color(0xFFD9C9B3), Color(0xFF4A3F34)];
    return CustomPaint(
      painter: _RoomPainter(
        base: colors.first,
        deep: colors.last,
        showFurniture: showFurniture,
        seed: seed,
      ),
      size: Size.infinite,
    );
  }
}

class _RoomPainter extends CustomPainter {
  _RoomPainter({
    required this.base,
    required this.deep,
    required this.showFurniture,
    required this.seed,
  });

  final Color base;
  final Color deep;
  final bool showFurniture;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Wall wash (top-to-bottom soft gradient).
    final wallRect = Rect.fromLTWH(0, 0, w, h);
    final wallPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.lerp(base, Colors.white, 0.18)!,
          base,
        ],
      ).createShader(wallRect);
    canvas.drawRect(wallRect, wallPaint);

    // Floor: a warm plane occupying the lower third with slight perspective.
    final floorTop = h * 0.66;
    final floorPath = Path()
      ..moveTo(0, floorTop)
      ..lineTo(w, floorTop)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    final floorPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.lerp(deep, Colors.black, 0.05)!,
          Color.lerp(deep, Colors.black, 0.28)!,
        ],
      ).createShader(Rect.fromLTWH(0, floorTop, w, h - floorTop));
    canvas.drawPath(floorPath, floorPaint);

    // A tall window on the left with soft daylight.
    final windowRect = Rect.fromLTWH(w * 0.07, h * 0.12, w * 0.24, h * 0.46);
    final windowPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.55),
          Colors.white.withOpacity(0.12),
        ],
      ).createShader(windowRect);
    final windowR = RRect.fromRectAndRadius(
      windowRect,
      const Radius.circular(6),
    );
    canvas.drawRRect(windowR, windowPaint);
    // Window frame lines.
    final frame = Paint()
      ..color = Colors.white.withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(windowR, frame);
    canvas.drawLine(
      Offset(windowRect.center.dx, windowRect.top),
      Offset(windowRect.center.dx, windowRect.bottom),
      frame,
    );
    canvas.drawLine(
      Offset(windowRect.left, windowRect.center.dy),
      Offset(windowRect.right, windowRect.center.dy),
      frame,
    );

    if (showFurniture) {
      // Sofa silhouette on the floor, right of centre.
      final sofaColor = Color.lerp(deep, Colors.white, 0.14)!;
      final sofaPaint = Paint()..color = sofaColor;
      final sofaBody = RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.42, h * 0.5, w * 0.44, h * 0.2),
        const Radius.circular(14),
      );
      canvas.drawRRect(sofaBody, sofaPaint);
      // Sofa back cushion.
      final sofaBack = RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.42, h * 0.42, w * 0.44, h * 0.12),
        const Radius.circular(12),
      );
      canvas.drawRRect(
        sofaBack,
        Paint()..color = Color.lerp(sofaColor, Colors.black, 0.08)!,
      );

      // A round side table / rug hint.
      final tablePaint = Paint()
        ..color = Color.lerp(deep, Colors.black, 0.35)!.withOpacity(0.9);
      canvas.drawOval(
        Rect.fromLTWH(w * 0.5, h * 0.74, w * 0.28, h * 0.09),
        tablePaint,
      );

      // A floor lamp / plant near the window.
      final accent = Paint()..color = Colors.white.withOpacity(0.7);
      canvas.drawCircle(Offset(w * 0.36, h * 0.46), w * 0.03, accent);
      final stem = Paint()
        ..color = Colors.white.withOpacity(0.4)
        ..strokeWidth = 3;
      canvas.drawLine(
        Offset(w * 0.36, h * 0.49),
        Offset(w * 0.36, h * 0.66),
        stem,
      );
    }

    // Soft vignette to add depth.
    final vignette = Paint()
      ..shader = RadialGradient(
        colors: [Colors.transparent, Colors.black.withOpacity(0.16)],
        stops: const [0.7, 1.0],
      ).createShader(wallRect);
    canvas.drawRect(wallRect, vignette);
  }

  @override
  bool shouldRepaint(covariant _RoomPainter old) =>
      old.base != base || old.deep != deep || old.showFurniture != showFurniture;
}
