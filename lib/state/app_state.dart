import 'package:flutter/foundation.dart';

import '../models/card_model.dart';
import '../models/transaction_model.dart';
import '../data/sample_data.dart';

class AppState extends ChangeNotifier {
  final List<CardModel> _cards = List.of(sampleCards);
  final List<TransactionModel> _transactions = List.of(sampleTransactions);

  List<CardModel> get cards => List.unmodifiable(_cards);

  List<CardModel> get debitCards =>
      List.unmodifiable(_cards.where((card) => card.type == CardType.debit));

  List<CardModel> get creditCards =>
      List.unmodifiable(_cards.where((card) => card.type == CardType.credit));

  List<TransactionModel> get transactions => List.unmodifiable(_transactions);

  CardModel cardById(String id) => _cards.firstWhere((c) => c.id == id);

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

  double get totalOutstanding => _cards
      .where((c) => c.isCredit)
      .fold(0.0, (sum, c) => sum + c.currentBalance);

  double get totalSpentThisCycle {
    double total = 0;
    for (final c in _cards) {
      total += transactionsForCurrentCycle(c.id)
          .where((t) => !t.isCredit)
          .fold(0.0, (s, t) => s + t.amount);
    }
    return total;
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
    _cards.removeWhere((c) => c.id == id);
    _transactions.removeWhere((t) => t.cardId == id);
    notifyListeners();
  }

  void addTransaction(TransactionModel txn) {
    _transactions.add(txn);
    final idx = _cards.indexWhere((c) => c.id == txn.cardId);
    if (idx != -1) {
      final card = _cards[idx];
      final delta = txn.isCredit ? -txn.amount : txn.amount;
      final newBalance = (card.currentBalance + delta).clamp(
        0,
        double.infinity,
      );
      _cards[idx] = card.copyWith(currentBalance: newBalance.toDouble());
    }
    notifyListeners();
  }

  void deleteTransaction(String id) {
    final idx = _transactions.indexWhere((t) => t.id == id);
    if (idx == -1) return;
    final txn = _transactions[idx];
    final cardIdx = _cards.indexWhere((c) => c.id == txn.cardId);
    if (cardIdx != -1) {
      final card = _cards[cardIdx];
      final delta = txn.isCredit ? -txn.amount : txn.amount;
      final newBalance = (card.currentBalance - delta).clamp(
        0,
        double.infinity,
      );
      _cards[cardIdx] = card.copyWith(currentBalance: newBalance.toDouble());
    }
    _transactions.removeAt(idx);
    notifyListeners();
  }
}
