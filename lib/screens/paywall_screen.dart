import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../app_state.dart';
import '../data/app_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/primary_button.dart';
import '../widgets/room_art.dart';
import 'home/home_shell.dart';

/// The highest-craft screen: premium, HONEST paywall. Clear pricing, real
/// feature list, transparent terms, and a tasteful escape hatch — designed to
/// convert through desire and trust, not dark patterns.
class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key, this.fromOnboarding = false});
  final bool fromOnboarding;

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  String _selected = 'yearly';

  void _continueFree() {
    _goHome();
  }

  void _subscribe() {
    AppScope.of(context).setPro(true);
    _goHome();
  }

  void _goHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeShell()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Rich hero art top third.
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.42,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: const [
                RoomArt(styleName: 'Midnight Deco Warmth'),
                DecoratedBox(
                  decoration: BoxDecoration(gradient: AppGradients.bottomScrim),
                ),
              ],
            ),
          ),
          // Close / not-now escape.
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: GestureDetector(
                  onTap: _continueFree,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.espresso.withOpacity(0.35),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close,
                        color: AppColors.white, size: 20),
                  ),
                ),
              ),
            ),
          ),
          // Sheet content.
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.30),
              decoration: BoxDecoration(
                color: context.c.background,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadii.xl)),
              ),
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.page,
                      AppSpacing.xl, AppSpacing.page, AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Pill(
                          label: 'Lumo Pro',
                          gradient: AppGradients.gold,
                          textColor: AppColors.espresso,
                          icon: Icons.auto_awesome,
                        ),
                      ).animate().fadeIn().scale(
                          begin: const Offset(0.9, 0.9),
                          end: const Offset(1, 1)),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Design without limits.',
                        textAlign: TextAlign.center,
                        style: AppTypography.headline(context.c.onBackground),
                      ).animate().fadeIn(delay: 100.ms),
                      const SizedBox(height: AppSpacing.lg),
                      ...AppData.proFeatures.map(_featureRow),
                      const SizedBox(height: AppSpacing.lg),
                      ...AppData.plans.map(_planCard),
                      const SizedBox(height: AppSpacing.lg),
                      PrimaryButton(
                        label: _selected == 'yearly'
                            ? 'Start yearly plan'
                            : 'Start weekly plan',
                        onPressed: _subscribe,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Center(
                        child: Text(
                          'No free-trial traps. Cancel anytime in Settings.',
                          style: AppTypography.label(context.c.secondaryText),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TextButton(
                        onPressed: _continueFree,
                        child: Text('Maybe later — continue with 3 free designs',
                            style: AppTypography.label(context.c.secondaryText)),
                      ),
                      const _LegalRow(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              gradient: AppGradients.accent,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 14, color: AppColors.white),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(text,
                style: AppTypography.body(context.c.onBackground)),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 150.ms).moveX(begin: 12, end: 0);
  }

  Widget _planCard(PlanOption plan) {
    final isSel = _selected == plan.id;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: GestureDetector(
        onTap: () => setState(() => _selected = plan.id),
        child: AnimatedContainer(
          duration: AppDurations.fast,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: isSel
                ? AppColors.terracotta.withOpacity(0.08)
                : context.c.surface,
            borderRadius: AppRadii.all(AppRadii.md),
            border: Border.all(
              color: isSel ? AppColors.terracotta : context.c.outline,
              width: isSel ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              _radio(isSel),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(plan.title,
                            style: AppTypography.bodyStrong(
                                context.c.onBackground)),
                        if (plan.badge != null) ...[
                          const SizedBox(width: AppSpacing.sm),
                          Pill(
                            label: plan.badge!,
                            color: AppColors.success.withOpacity(0.15),
                            textColor: AppColors.success,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(plan.perLine,
                        style: AppTypography.label(context.c.secondaryText)),
                  ],
                ),
              ),
              Text(plan.priceLine,
                  style: AppTypography.bodyStrong(context.c.onBackground)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _radio(bool selected) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.terracotta : context.c.outline,
          width: 2,
        ),
        color: selected ? AppColors.terracotta : Colors.transparent,
      ),
      child: selected
          ? const Icon(Icons.check, size: 14, color: AppColors.white)
          : null,
    );
  }
}

class _LegalRow extends StatelessWidget {
  const _LegalRow();

  @override
  Widget build(BuildContext context) {
    final style = AppTypography.label(context.c.secondaryText);
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Restore', style: style),
          _dot(context),
          Text('Terms', style: style),
          _dot(context),
          Text('Privacy', style: style),
        ],
      ),
    );
  }

  Widget _dot(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Text('•', style: AppTypography.label(context.c.secondaryText)),
      );
}
