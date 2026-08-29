import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/app_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_gradients.dart';
import '../../theme/app_theme.dart';
import '../../theme/app_typography.dart';
import '../../widgets/before_after_slider.dart';
import '../../widgets/common.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/style_tile.dart';
import '../paywall_screen.dart';

/// The conversion-optimized onboarding: hero → problem → results → segment →
/// value, ending at the paywall. Uses a shared page controller with a soft
/// progress indicator and animated per-page content.
class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _controller = PageController();
  int _page = 0;
  int? _selectedSegment;

  static const _pageCount = 5;

  void _next() {
    if (_page < _pageCount - 1) {
      _controller.nextPage(
        duration: AppDurations.base,
        curve: AppDurations.easeOut,
      );
    } else {
      _finish();
    }
  }

  void _finish() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const PaywallScreen(fromOnboarding: true)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (i) => setState(() => _page = i),
            children: [
              _HeroPage(onContinue: _next),
              _ProblemPage(onContinue: _next),
              _ResultsPage(onContinue: _next),
              _SegmentPage(
                selected: _selectedSegment,
                onSelect: (i) => setState(() => _selectedSegment = i),
                onContinue: _next,
              ),
              _ValuePage(onContinue: _next),
            ],
          ),
          // Progress dots + skip.
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.page,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  _ProgressDots(count: _pageCount, index: _page),
                  const Spacer(),
                  TextButton(
                    onPressed: _finish,
                    child: Text('Skip',
                        style: AppTypography.label(context.c.secondaryText)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressDots extends StatelessWidget {
  const _ProgressDots({required this.count, required this.index});
  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count, (i) {
        final active = i == index;
        return AnimatedContainer(
          duration: AppDurations.fast,
          margin: const EdgeInsets.only(right: 6),
          width: active ? 22 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: active ? AppColors.terracotta : context.c.outline,
            borderRadius: AppRadii.all(AppRadii.pill),
          ),
        );
      }),
    );
  }
}

/// Shared bottom CTA area so pages line up perfectly.
class _OnboardingScaffold extends StatelessWidget {
  const _OnboardingScaffold({
    required this.child,
    required this.ctaLabel,
    required this.onContinue,
  });

  final Widget child;
  final String ctaLabel;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(child: child),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.page),
            child: PrimaryButton(label: ctaLabel, onPressed: onContinue),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Page 1 — Hero
// ---------------------------------------------------------------------------
class _HeroPage extends StatelessWidget {
  const _HeroPage({required this.onContinue});
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return _OnboardingScaffold(
      ctaLabel: 'Continue',
      onContinue: onContinue,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.page, 56, AppSpacing.page, AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            AspectRatio(
              aspectRatio: 4 / 5,
              child: const BeforeAfterSlider(styleName: 'Collected Mid-Century'),
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(begin: const Offset(0.96, 0.96), end: const Offset(1, 1)),
            const SizedBox(height: AppSpacing.xl),
            Text('Your room,\nactually yours.',
                    style: AppTypography.display(context.c.onBackground))
                .animate()
                .fadeIn(delay: 200.ms)
                .moveY(begin: 14, end: 0),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Lumo reimagines your real space in seconds — keeping your walls, '
              'windows and light exactly where they are.',
              style: AppTypography.body(context.c.secondaryText),
            ).animate().fadeIn(delay: 350.ms),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Page 2 — The problem with other apps
// ---------------------------------------------------------------------------
class _ProblemPage extends StatelessWidget {
  const _ProblemPage({required this.onContinue});
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return _OnboardingScaffold(
      ctaLabel: 'Lumo is different',
      onContinue: onContinue,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.page, 72, AppSpacing.page, AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'The problem with other apps',
              title: 'Generic results that\nlook nothing like home.',
            ).animate().fadeIn().moveY(begin: 12, end: 0),
            const SizedBox(height: AppSpacing.xl),
            ...List.generate(AppData.problemQuotes.length, (i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: SoftCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      Text('“',
                          style: AppTypography.headline(
                              AppColors.terracotta.withOpacity(0.7))),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          AppData.problemQuotes[i],
                          style: AppTypography.body(context.c.onBackground),
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: (150 * (i + 1)).ms)
                  .moveX(begin: 18, end: 0, curve: Curves.easeOut);
            }),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Page 3 — Results gallery
// ---------------------------------------------------------------------------
class _ResultsPage extends StatelessWidget {
  const _ResultsPage({required this.onContinue});
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final styles = AppData.styles.take(4).toList();
    return _OnboardingScaffold(
      ctaLabel: 'Continue',
      onContinue: onContinue,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.page, 72, AppSpacing.page, AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'Curated by designers',
              title: 'Styles worthy of\na home magazine.',
              subtitle:
                  'Hand-tuned vibes that stay true to your space — delivered '
                  'with real taste, not random noise.',
            ).animate().fadeIn().moveY(begin: 12, end: 0),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(styles.length, (i) {
                  return StyleTile(name: styles[i])
                      .animate()
                      .fadeIn(delay: (120 * i).ms)
                      .scale(
                          begin: const Offset(0.92, 0.92),
                          end: const Offset(1, 1));
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Page 4 — Segmentation
// ---------------------------------------------------------------------------
class _SegmentPage extends StatelessWidget {
  const _SegmentPage({
    required this.selected,
    required this.onSelect,
    required this.onContinue,
  });
  final int? selected;
  final ValueChanged<int> onSelect;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return _OnboardingScaffold(
      ctaLabel: 'Continue',
      onContinue: onContinue,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.page, 72, AppSpacing.page, AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'Tell us about you',
              title: 'What brings you\nto Lumo?',
            ).animate().fadeIn().moveY(begin: 12, end: 0),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: ListView.separated(
                itemCount: AppData.segments.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, i) {
                  final seg = AppData.segments[i];
                  final isSel = selected == i;
                  return GestureDetector(
                    onTap: () => onSelect(i),
                    child: AnimatedContainer(
                      duration: AppDurations.fast,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: isSel
                            ? AppColors.terracotta.withOpacity(0.10)
                            : context.c.surface,
                        borderRadius: AppRadii.all(AppRadii.md),
                        border: Border.all(
                          color: isSel
                              ? AppColors.terracotta
                              : context.c.outline,
                          width: isSel ? 2 : 1,
                        ),
                        boxShadow: isSel ? null : AppShadows.soft,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: isSel
                                  ? AppColors.terracotta
                                  : context.c.background,
                              borderRadius: AppRadii.all(AppRadii.sm),
                            ),
                            child: Icon(seg.icon,
                                color: isSel
                                    ? AppColors.white
                                    : context.c.secondaryText),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(seg.title,
                                    style: AppTypography.bodyStrong(
                                        context.c.onBackground)),
                                const SizedBox(height: 2),
                                Text(seg.subtitle,
                                    style: AppTypography.label(
                                        context.c.secondaryText)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: (100 * i).ms)
                      .moveY(begin: 10, end: 0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Page 5 — Value / social proof
// ---------------------------------------------------------------------------
class _ValuePage extends StatelessWidget {
  const _ValuePage({required this.onContinue});
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return _OnboardingScaffold(
      ctaLabel: 'Start designing',
      onContinue: onContinue,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.page, 72, AppSpacing.page, AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (_) => const Icon(Icons.star_rounded,
                    color: AppColors.gold, size: 30),
              ),
            ).animate().fadeIn().scale(
                begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
            const SizedBox(height: AppSpacing.md),
            Text('Loved by home lovers',
                    style: AppTypography.headline(context.c.onBackground),
                    textAlign: TextAlign.center)
                .animate()
                .fadeIn(delay: 200.ms),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Join thousands reimagining the spaces they live in — honestly, '
              'beautifully, and true to the room they already have.',
              textAlign: TextAlign.center,
              style: AppTypography.body(context.c.secondaryText),
            ).animate().fadeIn(delay: 300.ms),
            const SizedBox(height: AppSpacing.xl),
            const SoftCard(
              child: Row(
                children: [
                  Icon(Icons.format_quote_rounded,
                      color: AppColors.terracotta),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      'Finally an app that redesigned MY room, not some '
                      'random one. I could actually picture it.',
                      style: TextStyle(height: 1.5),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 450.ms).moveY(begin: 12, end: 0),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
