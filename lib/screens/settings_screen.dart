import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import 'paywall_screen.dart';

/// Settings: account, appearance (working light/dark toggle), subscription,
/// and legal links.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final isDark = state.themeMode == ThemeMode.dark;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.page, AppSpacing.lg, AppSpacing.page, AppSpacing.xl),
          children: [
            Text('Settings',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: context.c.onBackground,
                )),
            const SizedBox(height: AppSpacing.lg),
            // Account / plan card.
            SoftCard(
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: state.isPro
                          ? AppGradients.gold
                          : AppGradients.accent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      state.isPro ? Icons.auto_awesome : Icons.person_outline,
                      color: state.isPro
                          ? AppColors.espresso
                          : AppColors.white,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.isPro ? 'Lumo Pro' : 'Free plan',
                            style: AppTypography.bodyStrong(
                                context.c.onBackground)),
                        Text(
                            state.isPro
                                ? 'Unlimited designs unlocked'
                                : '3 free designs remaining',
                            style: AppTypography.label(
                                context.c.secondaryText)),
                      ],
                    ),
                  ),
                  if (!state.isPro)
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const PaywallScreen()),
                      ),
                      child: Pill(
                        label: 'Upgrade',
                        gradient: AppGradients.accent,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _sectionLabel(context, 'Appearance'),
            SoftCard(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              child: Row(
                children: [
                  Icon(isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                      color: context.c.onBackground),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text('Dark mode',
                        style: AppTypography.body(context.c.onBackground)),
                  ),
                  Switch(
                    value: isDark,
                    activeColor: AppColors.terracotta,
                    onChanged: (_) => state.toggleTheme(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _sectionLabel(context, 'Subscription'),
            _tile(context, Icons.workspace_premium_outlined,
                'Manage subscription'),
            _tile(context, Icons.restore, 'Restore purchases'),
            const SizedBox(height: AppSpacing.lg),
            _sectionLabel(context, 'About'),
            _tile(context, Icons.description_outlined, 'Terms of use'),
            _tile(context, Icons.privacy_tip_outlined, 'Privacy policy'),
            _tile(context, Icons.star_outline, 'Rate Lumo'),
            const SizedBox(height: AppSpacing.xl),
            Center(
              child: Text('Lumo · v1.0.0',
                  style: AppTypography.label(context.c.secondaryText)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(BuildContext context, String text) => Padding(
        padding: const EdgeInsets.only(
            left: AppSpacing.xs, bottom: AppSpacing.sm),
        child: Text(text.toUpperCase(),
            style: AppTypography.overline(context.c.secondaryText)),
      );

  Widget _tile(BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: SoftCard(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        onTap: () {},
        child: Row(
          children: [
            Icon(icon, color: context.c.onBackground, size: 22),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(label,
                  style: AppTypography.body(context.c.onBackground)),
            ),
            Icon(Icons.chevron_right, color: context.c.secondaryText),
          ],
        ),
      ),
    );
  }
}
