import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app_state.dart';
import '../../data/app_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_gradients.dart';
import '../../theme/app_theme.dart';
import '../../theme/app_typography.dart';
import '../../widgets/common.dart';
import '../../widgets/room_art.dart';
import '../capture_screen.dart';

/// The home hub — "Let's design your space". A hero CTA to start a new design,
/// plus tiles for Library, Moodboard and recent projects.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _startDesign(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CaptureScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.page,
                    AppSpacing.lg, AppSpacing.page, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top bar: wordmark + Pro/settings.
                    Row(
                      children: [
                        Text('Lumo',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              color: context.c.onBackground,
                            )),
                        const Spacer(),
                        if (state.isPro)
                          Pill(
                            label: 'Pro',
                            gradient: AppGradients.gold,
                            textColor: AppColors.espresso,
                            icon: Icons.auto_awesome,
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text('Let’s design\nyour space.',
                            style: AppTypography.display(context.c.onBackground))
                        .animate()
                        .fadeIn()
                        .moveY(begin: 12, end: 0),
                    const SizedBox(height: AppSpacing.sm),
                    Text('Where would you like to begin?',
                        style: AppTypography.body(context.c.secondaryText)),
                    const SizedBox(height: AppSpacing.lg),
                    _NewDesignCard(onTap: () => _startDesign(context))
                        .animate()
                        .fadeIn(delay: 150.ms)
                        .moveY(begin: 16, end: 0),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
            // Quick-action tiles.
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 1.15,
                children: [
                  _QuickTile(
                    title: 'Library',
                    subtitle: 'Revisit favourites',
                    icon: Icons.grid_view_rounded,
                    style: 'Coastal Linen',
                  ),
                  _QuickTile(
                    title: 'Moodboard',
                    subtitle: 'Curate ideas',
                    icon: Icons.dashboard_customize_outlined,
                    style: 'Japandi Calm',
                  ),
                  _QuickTile(
                    title: 'Keep what I own',
                    subtitle: 'Redesign around it',
                    icon: Icons.chair_outlined,
                    style: 'Walnut Cocoon',
                  ),
                  _QuickTile(
                    title: 'Shop the look',
                    subtitle: 'Find the pieces',
                    icon: Icons.shopping_bag_outlined,
                    style: 'Terracotta Adobe',
                  ),
                ]
                    .animate(interval: 90.ms)
                    .fadeIn(delay: 250.ms)
                    .scale(
                        begin: const Offset(0.94, 0.94),
                        end: const Offset(1, 1)),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.page,
                    AppSpacing.xl, AppSpacing.page, AppSpacing.md),
                child: Text('Explore vibes',
                    style: AppTypography.title(context.c.onBackground)),
              ),
            ),
            // Horizontal style carousel.
            SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.page),
                  itemCount: AppData.styles.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, i) {
                    final name = AppData.styles[i];
                    return GestureDetector(
                      onTap: () => _startDesign(context),
                      child: SizedBox(
                        width: 130,
                        child: ClipRRect(
                          borderRadius: AppRadii.all(AppRadii.md),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              RoomArt(styleName: name),
                              const DecoratedBox(
                                decoration: BoxDecoration(
                                    gradient: AppGradients.bottomScrim),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(AppSpacing.sm),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(name,
                                      style: AppTypography.label(
                                          AppColors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
          ],
        ),
      ),
    );
  }
}

class _NewDesignCard extends StatelessWidget {
  const _NewDesignCard({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 168,
        decoration: BoxDecoration(
          borderRadius: AppRadii.all(AppRadii.lg),
          boxShadow: AppShadows.accentGlow,
        ),
        child: ClipRRect(
          borderRadius: AppRadii.all(AppRadii.lg),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const RoomArt(styleName: 'Collected Mid-Century'),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.espresso.withOpacity(0.75),
                      AppColors.espresso.withOpacity(0.15),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Start a new design',
                        style: AppTypography.title(AppColors.white)),
                    const SizedBox(height: AppSpacing.xs),
                    Text('Snap or upload a room to begin',
                        style: AppTypography.label(
                            AppColors.white.withOpacity(0.85))),
                    const SizedBox(height: AppSpacing.md),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: AppRadii.all(AppRadii.pill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add,
                              size: 18, color: AppColors.espresso),
                          const SizedBox(width: 6),
                          Text('New design',
                              style: AppTypography.button(AppColors.espresso)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.style,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final String style;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: AppGradients.vibe(style),
              borderRadius: AppRadii.all(AppRadii.sm),
            ),
            child: Icon(icon, color: AppColors.white, size: 22),
          ),
          const Spacer(),
          Text(title, style: AppTypography.bodyStrong(context.c.onBackground)),
          const SizedBox(height: 2),
          Text(subtitle, style: AppTypography.label(context.c.secondaryText)),
        ],
      ),
    );
  }
}
