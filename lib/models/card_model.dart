import 'package:flutter/material.dart';

enum CardType { credit, debit }

enum CardNetwork { visa, mastercard, amex, rupay, discover }

extension CardNetworkLabel on CardNetwork {
  String get label {
    switch (this) {
      case CardNetwork.visa:
        return 'VISA';
      case CardNetwork.mastercard:
        return 'Mastercard';
      case CardNetwork.amex:
        return 'AMEX';
      case CardNetwork.rupay:
        return 'RuPay';
      case CardNetwork.discover:
        return 'Discover';
    }
  }
}

class CardModel {
  final String bank;
  final CardType type;
  final String name;
  final double balance;
  final double? creditLimit;
  final int lastDigit;
  final CardNetwork network;
  final int expiryMonth;
  final int expiryYear;
  final int? statementDay;
  final int? dueDay;
  final int palettteIndex;
  final String icon;

  const CardModel({
    required this.bank,
    required this.type,
    required this.name,
    required this.balance,
    this.creditLimit,
    required this.lastDigit,
    required this.network,
    required this.expiryMonth,
    required this.expiryYear,
    this.statementDay,
    this.dueDay,
    required this.palettteIndex,
    required this.icon,
  });

  CardModel updateBalance(CardModel card, double newBalance) {
    return CardModel(
      bank: card.bank,
      type: card.type,
      name: card.name,
      balance: newBalance,
      creditLimit: card.creditLimit,
      lastDigit: card.lastDigit,
      network: card.network,
      expiryMonth: card.expiryMonth,
      expiryYear: card.expiryYear,
      statementDay: card.statementDay,
      dueDay: card.dueDay,
      palettteIndex: card.palettteIndex,
      icon: card.icon,
    );
  }

  double get utilization {
    if (creditLimit == null || creditLimit == 0) return 0;
    return (balance / creditLimit!).clamp(0, 1);
  }

  bool get isCredit => type == CardType.credit;

  String get maskedNumber => '••••  ••••  ••••  $lastDigit';

  String get expiryLabel =>
      '${expiryMonth.toString().padLeft(2, '0')}/${(expiryYear % 100).toString().padLeft(2, '0')}';

  static int _clampDay(int day, int month, int year) {
    final lastDay = DateTime(year, month + 1, 0).day;
    return day > lastDay ? lastDay : day;
  }

  /// Next occurrence of [day] on/after [from].
  static DateTime _nextOccurrence(int day, DateTime from) {
    final thisMonthDay = _clampDay(day, from.month, from.year);
    final candidate = DateTime(from.year, from.month, thisMonthDay);
    if (!candidate.isBefore(DateTime(from.year, from.month, from.day))) {
      return candidate;
    }
    final nextMonth = from.month == 12 ? 1 : from.month + 1;
    final nextYear = from.month == 12 ? from.year + 1 : from.year;
    final nextDay = _clampDay(day, nextMonth, nextYear);
    return DateTime(nextYear, nextMonth, nextDay);
  }

  DateTime get nextStatementDate =>
      _nextOccurrence(statementDay!, DateTime.now());

  DateTime get nextDueDate => _nextOccurrence(dueDay!, DateTime.now());

  /// Start of the current billing cycle (previous statement date).
  DateTime get currentCycleStart {
    final now = DateTime.now();
    final thisMonthDay = _clampDay(statementDay!, now.month, now.year);
    final thisMonthStatement = DateTime(now.year, now.month, thisMonthDay);
    if (now.isBefore(thisMonthStatement)) {
      final prevMonth = now.month == 1 ? 12 : now.month - 1;
      final prevYear = now.month == 1 ? now.year - 1 : now.year;
      final prevDay = _clampDay(statementDay!, prevMonth, prevYear);
      return DateTime(prevYear, prevMonth, prevDay);
    }
    return thisMonthStatement;
  }

  int get daysUntilDue => nextDueDate
      .difference(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      )
      .inDays;

  double get minimumDue => isCredit ? (balance * 0.05).clamp(0, balance) : 0;
}
