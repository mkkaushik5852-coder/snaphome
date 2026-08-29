import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import 'onboarding/onboarding_flow.dart';

/// Animated logo reveal. The Lumo wordmark fades and scales in over a warm
/// wash, then transitions into onboarding.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: AppDurations.slow,
          pageBuilder: (_, __, ___) => const OnboardingFlow(),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.lightWash),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // A minimal drawn mark: a soft arch (doorway/home motif).
              CustomPaint(
                size: const Size(64, 64),
                painter: _ArchMarkPainter(),
              )
                  .animate()
                  .fadeIn(duration: 700.ms)
                  .scale(
                    begin: const Offset(0.7, 0.7),
                    end: const Offset(1, 1),
                    curve: Curves.easeOutBack,
                    duration: 800.ms,
                  ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Lumo',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 52,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: AppColors.espresso,
                ),
              )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 800.ms)
                  .moveY(begin: 12, end: 0, curve: Curves.easeOut),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'DESIGN THAT FEELS LIKE HOME',
                style: AppTypography.overline(AppColors.mocha),
              ).animate().fadeIn(delay: 700.ms, duration: 900.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArchMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()
      ..shader = AppGradients.accent
          .createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // An arch: two verticals joined by a semicircle top.
    final path = Path()
      ..moveTo(w * 0.2, h)
      ..lineTo(w * 0.2, h * 0.45)
      ..arcToPoint(Offset(w * 0.8, h * 0.45),
          radius: Radius.circular(w * 0.3))
      ..lineTo(w * 0.8, h);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
