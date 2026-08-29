import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../app_state.dart';
import '../data/app_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../widgets/before_after_slider.dart';
import '../widgets/common.dart';
import '../widgets/room_art.dart';

/// The payoff: a draggable before/after reveal, alternate variants, and
/// actions (save, share, regenerate, shop the look).
class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.styleName,
    required this.roomType,
  });
  final String styleName;
  final String roomType;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late String _current = widget.styleName;
  bool _saved = false;

  List<String> get _variants {
    final all = List<String>.from(AppData.styles)..remove(widget.styleName);
    return [widget.styleName, ...all.take(4)];
  }

  void _save() {
    if (_saved) return;
    AppScope.of(context).saveDesign(SavedDesign(
      styleName: _current,
      roomType: widget.roomType,
      createdAt: DateTime.now(),
    ));
    setState(() => _saved = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Saved to your library',
            style: AppTypography.label(AppColors.white)),
        backgroundColor: AppColors.espresso,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: context.c.onBackground,
        title: Text(widget.roomType,
            style: AppTypography.title(context.c.onBackground)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.ios_share),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.page, 0, AppSpacing.page, AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(_current,
                        style: AppTypography.headline(context.c.onBackground)),
                  ),
                  Pill(
                    label: 'Pro quality',
                    gradient: AppGradients.gold,
                    textColor: AppColors.espresso,
                    icon: Icons.auto_awesome,
                  ),
                ],
              ).animate().fadeIn(),
              const SizedBox(height: AppSpacing.md),
              AspectRatio(
                aspectRatio: 3 / 4,
                child: BeforeAfterSlider(styleName: _current),
              ).animate().fadeIn(delay: 100.ms).scale(
                  begin: const Offset(0.97, 0.97), end: const Offset(1, 1)),
              const SizedBox(height: AppSpacing.sm),
              Center(
                child: Text('Drag to compare before & after',
                    style: AppTypography.label(context.c.secondaryText)),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Try another variant',
                  style: AppTypography.label(context.c.secondaryText)),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 84,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _variants.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.sm),
                  itemBuilder: (context, i) {
                    final name = _variants[i];
                    final sel = name == _current;
                    return GestureDetector(
                      onTap: () => setState(() {
                        _current = name;
                        _saved = false;
                      }),
                      child: Container(
                        width: 84,
                        decoration: BoxDecoration(
                          borderRadius: AppRadii.all(AppRadii.sm),
                          border: Border.all(
                            color: sel
                                ? AppColors.terracotta
                                : Colors.transparent,
                            width: 2.5,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: AppRadii.all(AppRadii.sm - 2),
                          child: RoomArt(styleName: name),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              // Shop the look teaser.
              SoftCard(
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        gradient: AppGradients.vibe(_current),
                        borderRadius: AppRadii.all(AppRadii.sm),
                      ),
                      child: const Icon(Icons.shopping_bag_outlined,
                          color: AppColors.white),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Shop the look',
                              style: AppTypography.bodyStrong(
                                  context.c.onBackground)),
                          Text('Find the furniture & pieces in this design',
                              style: AppTypography.label(
                                  context.c.secondaryText)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: context.c.secondaryText),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      label: _saved ? 'Saved' : 'Save',
                      icon: _saved ? Icons.check : Icons.bookmark_outline,
                      onTap: _save,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _ActionButton(
                      label: 'Regenerate',
                      icon: Icons.refresh,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: context.c.surface,
          borderRadius: AppRadii.all(AppRadii.pill),
          border: Border.all(color: context.c.outline),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: context.c.onBackground),
            const SizedBox(width: 8),
            Text(label,
                style: AppTypography.button(context.c.onBackground)),
          ],
        ),
      ),
    );
  }
}
