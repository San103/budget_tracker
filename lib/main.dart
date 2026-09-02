import 'package:budget_tracker/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

import 'screens/account_screen.dart';
import 'state/app_scope.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const CardTrackerApp());
}

class CardTrackerApp extends StatefulWidget {
  const CardTrackerApp({super.key});

  @override
  State<CardTrackerApp> createState() => _CardTrackerAppState();
}

class _CardTrackerAppState extends State<CardTrackerApp> {
  final AppState _appState = AppState();

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: _appState,
      child: MaterialApp(
        title: 'Wallet',
        theme: buildAppTheme(brightness: Brightness.light),
        darkTheme: buildAppTheme(brightness: Brightness.dark),
        debugShowCheckedModeBanner: false,
        // theme: buildAppTheme(),
        home: const DashboardScreen(),
      ),
    );
  }
}
