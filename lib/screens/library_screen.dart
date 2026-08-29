import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../widgets/room_art.dart';

/// Grid of saved designs with a graceful empty state.
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final designs = state.savedDesigns;
    return Scaffold(
      body: SafeArea(
        child: designs.isEmpty
            ? _EmptyState()
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(AppSpacing.page,
                          AppSpacing.lg, AppSpacing.page, AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Library',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: context.c.onBackground,
                              )),
                          Text('${designs.length} saved design'
                              '${designs.length == 1 ? '' : 's'}',
                              style: AppTypography.body(
                                  context.c.secondaryText)),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.page),
                    sliver: SliverGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: AppSpacing.md,
                      crossAxisSpacing: AppSpacing.md,
                      childAspectRatio: 0.78,
                      children: List.generate(designs.length, (i) {
                        final d = designs[i];
                        return _DesignCard(
                          styleName: d.styleName,
                          roomType: d.roomType,
                        )
                            .animate()
                            .fadeIn(delay: (60 * i).ms)
                            .scale(
                                begin: const Offset(0.95, 0.95),
                                end: const Offset(1, 1));
                      }),
                    ),
                  ),
                  const SliverToBoxAdapter(
                      child: SizedBox(height: AppSpacing.xl)),
                ],
              ),
      ),
    );
  }
}

class _DesignCard extends StatelessWidget {
  const _DesignCard({required this.styleName, required this.roomType});
  final String styleName;
  final String roomType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppRadii.all(AppRadii.md),
        boxShadow: AppShadows.soft,
      ),
      child: ClipRRect(
        borderRadius: AppRadii.all(AppRadii.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  RoomArt(styleName: styleName),
                  const DecoratedBox(
                    decoration:
                        BoxDecoration(gradient: AppGradients.bottomScrim),
                  ),
                ],
              ),
            ),
            Container(
              color: context.c.surface,
              padding: const EdgeInsets.all(AppSpacing.md),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(styleName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          AppTypography.bodyStrong(context.c.onBackground)),
                  Text(roomType,
                      style: AppTypography.label(context.c.secondaryText)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: context.c.surface,
                shape: BoxShape.circle,
                boxShadow: AppShadows.soft,
              ),
              child: Icon(Icons.grid_view_rounded,
                  size: 38, color: context.c.secondaryText),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Your library awaits',
                style: AppTypography.headline(context.c.onBackground),
                textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Designs you save will live here — ready to revisit, compare '
              'and share anytime.',
              textAlign: TextAlign.center,
              style: AppTypography.body(context.c.secondaryText),
            ),
          ],
        ),
      ),
    );
  }
}
