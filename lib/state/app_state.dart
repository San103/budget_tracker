import 'package:budget_tracker/database/app_database.dart';
import 'package:flutter/material.dart';

import '../models/card_model.dart';
import '../models/transaction_model.dart';
import '../data/sample_data.dart';

class AppState extends ChangeNotifier {
  // LIGHT AND DARK MODE
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    notifyListeners();
  }
  //END OF LIGHT AND DARK MODE

  //DATABASE FETCH

  final AppDatabase database;

  AppState(this.database);

  List<Account> accounts = [];
  List<Transaction> transactions = [];
  double income = 0;
  double expenses = 0;

  Future<void> load() async {
    transactions = await database.getAllTransactions();
    print(transactions);
    income = await database.getTotalIncome();
    expenses = await database.getTotalExpenses();

    notifyListeners();
  }

  Future<void> deleteTransaction(int id) async {
    await database.deleteTransaction(id);
    await load();
    notifyListeners();
  }

  List<Account> get creditCards =>
      List.unmodifiable(accounts.where((card) => card.type == 'credit'));

  Future<void> addTransaction() async {
    await database.addTransaction(
      accountId: 2,
      type: 'expense',
      title: 'Utang',
      category: 'Shopping',
      amount: 1500.90,
      date: DateTime.now(),
    );

    await load();

    notifyListeners();
  }

  Future<void> addAccount({
    required String bank,
    required String name,
    required String type,
    required double balance,
    double? creditLimit,
    required int lastDigit,
    required String network,
    required int expiryMonth,
    required int expiryYear,
    int? statementDay,
    int? dueDay,
    required int paletteIndex,
    required String icon,
  }) async {
    //  bank: bank,
    //     name: name,
    //     type: type,
    //     balance: Value(balance),
    //     creditLimit: Value(creditLimit),
    //     lastDigit: Value(lastDigit),
    //     network: network,
    //     expiryMonth: Value(expiryMonth),
    //     expiryYear: Value(expiryYear),
    //     statementDay: Value(statementDay),
    //     dueDay: Value(dueDay),
    //     paletteIndex: Value(paletteIndex),
    //     icon: icon,

    // await database.addAccount(
    //   name: 2,
    //   type: 'income',
    //   creditLimit: 25000,
    //   paletteIndex: 1,
    //   amount: 1500.90,
    //   icon: DateTime.now(),
    // );

    await load();

    notifyListeners();
  }

  //END OF DB FETCH

  final List<CardModel> _cards = List.of(sampleCards);
  final List<TransactionModel> _transactions = List.of(sampleTransactions);

  List<CardModel> get cards => List.unmodifiable(_cards);

  List<CardModel> get debitCards =>
      List.unmodifiable(_cards.where((card) => card.type == CardType.debit));

  CardModel cardById(String id) => _cards.first;

  List<TransactionModel> transactionsForCard(String cardId) {
    final list = _transactions.where((t) => t.cardId == cardId).toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  List<TransactionModel> transactionsForCurrentCycle(String cardId) {
    final card = cardById(cardId);
    final start = card.currentCycleStart;
    return transactionsForCard(cardId)
        .where((t) => !t.date.isBefore(start))
        .toList();
  }

  List<TransactionModel> get recentTransactions {
    final list = List.of(_transactions);
    list.sort((a, b) => b.date.compareTo(a.date));
    return list.take(8).toList();
  }

  double get totalOutstanding =>
      _cards.where((c) => c.isCredit).fold(0.0, (sum, c) => sum + c.balance);

  double get totalSpentThisCycle {
    double total = 0;
    // for (final c in _cards) {
    //   total += transactionsForCurrentCycle(c.id)
    //       .where((t) => !t.isCredit)
    //       .fold(0.0, (s, t) => s + t.amount);
    // }
    // return total;
    return 0;
  }

  Map<String, double> categoryBreakdown(String cardId) {
    final txns = transactionsForCurrentCycle(cardId).where((t) => !t.isCredit);
    final map = <String, double>{};
    for (final t in txns) {
      map[t.category] = (map[t.category] ?? 0) + t.amount;
    }
    return map;
  }

  void addCard(CardModel card) {
    _cards.add(card);
    notifyListeners();
  }

  void removeCard(String id) {
    // _cards.removeWhere((c) => c.id == id);
    // _transactions.removeWhere((t) => t.cardId == id);
    // notifyListeners();
  }

  // void addTransaction(TransactionModel txn) {
  //   _transactions.add(txn);
  //   final idx = _cards.indexWhere((c) => c.id == txn.cardId);
  //   if (idx != -1) {
  //     final card = _cards[idx];
  //     final delta = txn.isCredit ? -txn.amount : txn.amount;
  //     final newBalance = (card.currentBalance + delta).clamp(
  //       0,
  //       double.infinity,
  //     );
  //     _cards[idx] = card.copyWith(currentBalance: newBalance.toDouble());
  //   }
  //   notifyListeners();
  // }

  // void deleteTransaction(String id) {
  //   final idx = _transactions.indexWhere((t) => t.id == id);
  //   if (idx == -1) return;
  //   final txn = _transactions[idx];
  //   final cardIdx = _cards.indexWhere((c) => c.id == txn.cardId);
  //   if (cardIdx != -1) {
  //     final card = _cards[cardIdx];
  //     final delta = txn.isCredit ? -txn.amount : txn.amount;
  //     final newBalance = (card.currentBalance - delta).clamp(
  //       0,
  //       double.infinity,
  //     );
  //     _cards[cardIdx] = card.copyWith(currentBalance: newBalance.toDouble());
  //   }
  //   _transactions.removeAt(idx);
  //   notifyListeners();
  // }
}
