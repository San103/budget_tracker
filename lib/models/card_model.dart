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
  final String id;
  final String bank;
  final String holderName;
  final String last4;
  final CardNetwork network;
  final CardType type;
  final int expiryMonth;
  final int expiryYear; // 4-digit
  final double? creditLimit; // null for debit
  final double currentBalance; // outstanding (credit) or spent-this-cycle (debit)
  final double availableBalance; // for debit: account balance
  final int statementDay; // 1-28, day of month statement is generated
  final int dueDay; // 1-28, day of month payment is due (credit only, meaningful)
  final List<Color> gradient;

  const CardModel({
    required this.id,
    required this.bank,
    required this.holderName,
    required this.last4,
    required this.network,
    required this.type,
    required this.expiryMonth,
    required this.expiryYear,
    this.creditLimit,
    required this.currentBalance,
    this.availableBalance = 0,
    required this.statementDay,
    required this.dueDay,
    required this.gradient,
  });

  CardModel copyWith({
    double? currentBalance,
    double? availableBalance,
  }) {
    return CardModel(
      id: id,
      bank: bank,
      holderName: holderName,
      last4: last4,
      network: network,
      type: type,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      creditLimit: creditLimit,
      currentBalance: currentBalance ?? this.currentBalance,
      availableBalance: availableBalance ?? this.availableBalance,
      statementDay: statementDay,
      dueDay: dueDay,
      gradient: gradient,
    );
  }

  double get utilization {
    if (creditLimit == null || creditLimit == 0) return 0;
    return (currentBalance / creditLimit!).clamp(0, 1);
  }

  bool get isCredit => type == CardType.credit;

  String get maskedNumber => '••••  ••••  ••••  $last4';

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
      _nextOccurrence(statementDay, DateTime.now());

  DateTime get nextDueDate => _nextOccurrence(dueDay, DateTime.now());

  /// Start of the current billing cycle (previous statement date).
  DateTime get currentCycleStart {
    final now = DateTime.now();
    final thisMonthDay = _clampDay(statementDay, now.month, now.year);
    final thisMonthStatement = DateTime(now.year, now.month, thisMonthDay);
    if (now.isBefore(thisMonthStatement)) {
      final prevMonth = now.month == 1 ? 12 : now.month - 1;
      final prevYear = now.month == 1 ? now.year - 1 : now.year;
      final prevDay = _clampDay(statementDay, prevMonth, prevYear);
      return DateTime(prevYear, prevMonth, prevDay);
    }
    return thisMonthStatement;
  }

  int get daysUntilDue => nextDueDate.difference(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      ).inDays;

  double get minimumDue =>
      isCredit ? (currentBalance * 0.05).clamp(0, currentBalance) : 0;
}
