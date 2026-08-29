import 'package:flutter/material.dart';

/// Very small app-wide state for the prototype: theme mode + whether the user
/// has "subscribed" (so the paywall doesn't nag repeatedly) + saved designs.
class AppState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  bool _isPro = false;
  bool get isPro => _isPro;

  final List<SavedDesign> savedDesigns = [];

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setPro(bool value) {
    _isPro = value;
    notifyListeners();
  }

  void saveDesign(SavedDesign design) {
    savedDesigns.insert(0, design);
    notifyListeners();
  }
}

class SavedDesign {
  SavedDesign({
    required this.styleName,
    required this.roomType,
    required this.createdAt,
  });
  final String styleName;
  final String roomType;
  final DateTime createdAt;
}

/// Inherited access to [AppState] without pulling in a package.
class AppScope extends InheritedNotifier<AppState> {
  const AppScope({
    super.key,
    required AppState state,
    required super.child,
  }) : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found in context');
    return scope!.notifier!;
  }
}
