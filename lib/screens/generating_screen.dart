import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../widgets/room_art.dart';
import 'result_screen.dart';

/// A mesmerizing premium loading state: the room art gently materialises behind
/// a shimmering scrim while reassuring copy cycles and progress advances.
class GeneratingScreen extends StatefulWidget {
  const GeneratingScreen({
    super.key,
    required this.styleName,
    required this.roomType,
  });
  final String styleName;
  final String roomType;

  @override
  State<GeneratingScreen> createState() => _GeneratingScreenState();
}

class _GeneratingScreenState extends State<GeneratingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..forward();

  int _stepIndex = 0;
  Timer? _copyTimer;

  static const _steps = [
    'Reading your room’s light and layout…',
    'Preserving walls, windows and doors…',
    'Styling with your chosen vibe…',
    'Adding the finishing touches…',
  ];

  @override
  void initState() {
    super.initState();
    _copyTimer = Timer.periodic(const Duration(milliseconds: 1000), (t) {
      if (!mounted) return;
      setState(() => _stepIndex = (_stepIndex + 1) % _steps.length);
    });
    _ctrl.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ResultScreen(
              styleName: widget.styleName,
              roomType: widget.roomType,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _copyTimer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Room art fading in.
          RoomArt(styleName: widget.styleName)
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .fadeIn(duration: 900.ms)
              .then()
              .shimmer(
                  duration: 1600.ms,
                  color: Colors.white.withOpacity(0.15)),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xAA16120E), Color(0xEE16120E)],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.page),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  // Animated concentric pulse.
                  SizedBox(
                    width: 96,
                    height: 96,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppGradients.accent,
                            boxShadow: AppShadows.accentGlow,
                          ),
                        )
                            .animate(onPlay: (c) => c.repeat(reverse: true))
                            .scale(
                              begin: const Offset(0.85, 0.85),
                              end: const Offset(1.05, 1.05),
                              duration: 1200.ms,
                              curve: Curves.easeInOut,
                            ),
                        const Icon(Icons.auto_awesome,
                            color: AppColors.white, size: 34),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text('Designing your ${widget.roomType.toLowerCase()}',
                      style: AppTypography.headline(AppColors.boneOnDark),
                      textAlign: TextAlign.center),
                  const SizedBox(height: AppSpacing.sm),
                  AnimatedSwitcher(
                    duration: AppDurations.base,
                    child: Text(
                      _steps[_stepIndex],
                      key: ValueKey(_stepIndex),
                      style: AppTypography.body(AppColors.mochaOnDark),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  // Progress bar.
                  ClipRRect(
                    borderRadius: AppRadii.all(AppRadii.pill),
                    child: AnimatedBuilder(
                      animation: _ctrl,
                      builder: (context, _) => LinearProgressIndicator(
                        value: _ctrl.value,
                        minHeight: 6,
                        backgroundColor: Colors.white.withOpacity(0.15),
                        valueColor: const AlwaysStoppedAnimation(
                            AppColors.terracotta),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text('“${widget.styleName}”',
                      style: AppTypography.title(AppColors.boneOnDark)),
                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
