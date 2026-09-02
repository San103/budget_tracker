import 'package:budget_tracker/database/app_database.dart';
import 'package:budget_tracker/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

import 'state/app_scope.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

final database = AppDatabase();

void main() {
  runApp(CardTrackerApp(database: database));
}

class CardTrackerApp extends StatefulWidget {
  final AppDatabase database;
  const CardTrackerApp({super.key, required this.database});

  @override
  State<CardTrackerApp> createState() => _CardTrackerAppState();
}

class _CardTrackerAppState extends State<CardTrackerApp> {
  late final AppState _appState;

  @override
  void initState() {
    super.initState();

    _appState = AppState(widget.database);

    // Load accounts, income, expenses, etc.
    _appState.load();
  }

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      //For Light and Darkmode
      animation: _appState,
      builder: (context, asyncSnapshot) {
        return AppScope(
          state: _appState,
          child: MaterialApp(
            title: 'Wallet',
            theme: buildAppTheme(brightness: Brightness.light),
            darkTheme: buildAppTheme(brightness: Brightness.dark),
            themeMode: _appState.themeMode,
            debugShowCheckedModeBanner: false,
            // theme: buildAppTheme(),
            home: const DashboardScreen(),
          ),
        );
      },
    );
  }
}
