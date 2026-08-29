import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../theme/app_typography.dart';
import '../library_screen.dart';
import '../settings_screen.dart';
import 'home_screen.dart';

/// Hosts the three primary tabs with a refined custom bottom bar.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _tabs = [
    _TabDef('Design', Icons.auto_awesome_outlined, Icons.auto_awesome),
    _TabDef('Library', Icons.grid_view_outlined, Icons.grid_view_rounded),
    _TabDef('Settings', Icons.tune_outlined, Icons.tune),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          HomeScreen(),
          LibraryScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: context.c.surface,
          boxShadow: AppShadows.soft,
          border: Border(top: BorderSide(color: context.c.outline, width: 0.5)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_tabs.length, (i) {
                final tab = _tabs[i];
                final active = i == _index;
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _index = i),
                  child: AnimatedContainer(
                    duration: AppDurations.fast,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          active ? tab.activeIcon : tab.icon,
                          color: active
                              ? AppColors.terracotta
                              : context.c.secondaryText,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tab.label,
                          style: AppTypography.overline(
                            active
                                ? AppColors.terracotta
                                : context.c.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabDef {
  const _TabDef(this.label, this.icon, this.activeIcon);
  final String label;
  final IconData icon;
  final IconData activeIcon;
}
