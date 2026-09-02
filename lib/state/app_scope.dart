import 'package:flutter/widgets.dart';
import 'app_state.dart';

/// Lightweight dependency injection for [AppState] using a built-in
/// InheritedNotifier — no external state-management package required.
class AppScope extends InheritedNotifier<AppState> {
  const AppScope({
    super.key,
    required AppState state,
    required super.child,
  }) : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found in widget tree');
    return scope!.notifier!;
  }
}
