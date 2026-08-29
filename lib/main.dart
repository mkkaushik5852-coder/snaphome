import 'package:flutter/material.dart';
import 'app_state.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const LumoApp());
}

/// Root of the Lumo application. Owns the [AppState], exposes it via [AppScope],
/// and rebuilds the [MaterialApp] when theme mode changes.
class LumoApp extends StatefulWidget {
  const LumoApp({super.key});

  @override
  State<LumoApp> createState() => _LumoAppState();
}

class _LumoAppState extends State<LumoApp> {
  final AppState _state = AppState();

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: _state,
      child: AnimatedBuilder(
        animation: _state,
        builder: (context, _) {
          return MaterialApp(
            title: 'Lumo',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: _state.themeMode,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
