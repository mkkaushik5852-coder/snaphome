import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/app_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/primary_button.dart';
import '../widgets/style_tile.dart';
import 'generating_screen.dart';

/// Step 2: choose a room type, a curated vibe, and optionally add a custom
/// prompt. The CTA enables once a style is selected.
class StylePickerScreen extends StatefulWidget {
  const StylePickerScreen({super.key});

  @override
  State<StylePickerScreen> createState() => _StylePickerScreenState();
}

class _StylePickerScreenState extends State<StylePickerScreen> {
  int _roomType = 0;
  String? _style;
  final TextEditingController _prompt = TextEditingController();

  @override
  void dispose() {
    _prompt.dispose();
    super.dispose();
  }

  void _generate() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GeneratingScreen(
          styleName: _style!,
          roomType: AppData.roomTypes[_roomType].label,
        ),
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
        title: Text('Choose your vibe',
            style: AppTypography.title(context.c.onBackground)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(AppSpacing.page, 0,
                          AppSpacing.page, AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Room type',
                              style: AppTypography.label(
                                  context.c.secondaryText)),
                          const SizedBox(height: AppSpacing.sm),
                          SizedBox(
                            height: 40,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: AppData.roomTypes.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: AppSpacing.sm),
                              itemBuilder: (context, i) {
                                final rt = AppData.roomTypes[i];
                                final sel = i == _roomType;
                                return GestureDetector(
                                  onTap: () => setState(() => _roomType = i),
                                  child: AnimatedContainer(
                                    duration: AppDurations.fast,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppSpacing.md,
                                        vertical: AppSpacing.sm),
                                    decoration: BoxDecoration(
                                      color: sel
                                          ? AppColors.terracotta
                                          : context.c.surface,
                                      borderRadius:
                                          AppRadii.all(AppRadii.pill),
                                      border: Border.all(
                                          color: sel
                                              ? AppColors.terracotta
                                              : context.c.outline),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(rt.icon,
                                            size: 16,
                                            color: sel
                                                ? AppColors.white
                                                : context.c.secondaryText),
                                        const SizedBox(width: 6),
                                        Text(rt.label,
                                            style: AppTypography.label(sel
                                                ? AppColors.white
                                                : context
                                                    .c.secondaryText)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Text('Curated vibes',
                              style: AppTypography.label(
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
                      children: List.generate(AppData.styles.length, (i) {
                        final name = AppData.styles[i];
                        return StyleTile(
                          name: name,
                          selected: _style == name,
                          onTap: () => setState(() => _style = name),
                        )
                            .animate()
                            .fadeIn(delay: (40 * i).ms)
                            .scale(
                                begin: const Offset(0.95, 0.95),
                                end: const Offset(1, 1));
                      }),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(AppSpacing.page,
                          AppSpacing.lg, AppSpacing.page, AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Add a note (optional)',
                              style: AppTypography.label(
                                  context.c.secondaryText)),
                          const SizedBox(height: AppSpacing.sm),
                          TextField(
                            controller: _prompt,
                            style:
                                AppTypography.body(context.c.onBackground),
                            decoration: InputDecoration(
                              hintText:
                                  'e.g. keep my sofa, add warm lighting…',
                              hintStyle: AppTypography.body(
                                  context.c.secondaryText),
                              filled: true,
                              fillColor: context.c.surface,
                              border: OutlineInputBorder(
                                borderRadius: AppRadii.all(AppRadii.md),
                                borderSide: BorderSide(
                                    color: context.c.outline),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: AppRadii.all(AppRadii.md),
                                borderSide: BorderSide(
                                    color: context.c.outline),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: AppRadii.all(AppRadii.md),
                                borderSide: const BorderSide(
                                    color: AppColors.terracotta, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.page),
              child: PrimaryButton(
                label: _style == null ? 'Select a vibe to continue' : 'Generate design',
                icon: _style == null ? null : Icons.auto_awesome,
                enabled: _style != null,
                onPressed: _style == null ? null : _generate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
