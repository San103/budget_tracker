import 'package:flutter/material.dart';

class SpendCategory {
  final String name;
  final IconData icon;
  const SpendCategory(this.name, this.icon);

  static const List<SpendCategory> all = [
    SpendCategory('Groceries', Icons.local_grocery_store_rounded),
    SpendCategory('Dining', Icons.restaurant_rounded),
    SpendCategory('Transport', Icons.directions_car_filled_rounded),
    SpendCategory('Shopping', Icons.shopping_bag_rounded),
    SpendCategory('Bills & Utilities', Icons.receipt_long_rounded),
    SpendCategory('Entertainment', Icons.movie_filter_rounded),
    SpendCategory('Health', Icons.favorite_rounded),
    SpendCategory('Travel', Icons.flight_takeoff_rounded),
    SpendCategory('Subscriptions', Icons.autorenew_rounded),
    SpendCategory('Other', Icons.category_rounded),
  ];

  static const List<SpendCategory> income = [
    SpendCategory('Salary', Icons.local_grocery_store_rounded),
    SpendCategory('Freelance', Icons.work_rounded),
    SpendCategory('Investment', Icons.trending_up_rounded),
    SpendCategory('Bonus', Icons.trending_up_rounded),
    SpendCategory('Other', Icons.trending_up_rounded),
  ];

  static SpendCategory byName(String name) =>
      all.firstWhere((c) => c.name == name, orElse: () => all.last);
}

class TransactionModel {
  final String id;
  final String cardId;
  final String title;
  final String category;
  final double amount; // always positive
  final DateTime date;
  final bool isCredit; // true = payment/refund reducing balance

  const TransactionModel({
    required this.id,
    required this.cardId,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    this.isCredit = false,
  });
}
