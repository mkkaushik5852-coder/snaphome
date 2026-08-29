import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/primary_button.dart';
import 'style_picker_screen.dart';

/// Capture / upload: choose camera or gallery. Uses image_picker (web-safe).
/// On web, camera falls back to gallery gracefully. For the prototype, either
/// path simply advances to the style picker.
class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _picking = false;

  Future<void> _pick(ImageSource source) async {
    if (_picking) return;
    setState(() => _picking = true);
    try {
      // Attempt a real pick; if unavailable (e.g. no camera on web) we still
      // proceed so the prototype flow is never blocked.
      await _picker.pickImage(source: source);
    } catch (_) {
      // Ignore — prototype proceeds regardless.
    } finally {
      if (mounted) setState(() => _picking = false);
    }
    _proceed();
  }

  void _proceed() {
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const StylePickerScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _bar(context, 'New design'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.page),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                eyebrow: 'Step 1 of 2',
                title: 'Add a photo\nof your room.',
                subtitle:
                    'A clear, well-lit shot gives Lumo the best sense of your '
                    'real space.',
              ).animate().fadeIn().moveY(begin: 10, end: 0),
              const SizedBox(height: AppSpacing.xl),
              // Framing target visual.
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: DottedFrame(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate_outlined,
                              size: 54, color: context.c.secondaryText),
                          const SizedBox(height: AppSpacing.md),
                          Text('Your room preview',
                              style: AppTypography.label(
                                  context.c.secondaryText)),
                        ],
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 200.ms),
              ),
              const SizedBox(height: AppSpacing.xl),
              if (!kIsWeb)
                PrimaryButton(
                  label: _picking ? 'Opening…' : 'Take a photo',
                  icon: Icons.camera_alt_outlined,
                  onPressed: () => _pick(ImageSource.camera),
                ),
              if (!kIsWeb) const SizedBox(height: AppSpacing.md),
              SecondaryButton(
                label: 'Choose from gallery',
                onPressed: () => _pick(ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

PreferredSizeWidget _bar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    foregroundColor: context.c.onBackground,
    title: Text(title, style: AppTypography.title(context.c.onBackground)),
    centerTitle: true,
  );
}

/// A rounded dashed border frame (drawn) around its child.
class DottedFrame extends StatelessWidget {
  const DottedFrame({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(color: context.c.outline),
      child: Container(
        decoration: BoxDecoration(
          color: context.c.surface,
          borderRadius: AppRadii.all(AppRadii.lg),
        ),
        child: child,
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(AppRadii.lg),
    );
    final path = Path()..addRRect(rrect);
    const dash = 8.0;
    const gap = 6.0;
    for (final metric in path.computeMetrics()) {
      double dist = 0;
      while (dist < metric.length) {
        canvas.drawPath(
          metric.extractPath(dist, dist + dash),
          paint,
        );
        dist += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter old) => old.color != color;
}
