import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../theme/app_theme.dart';

class CategoryIcon extends StatelessWidget {
  final String category;
  final double size;
  const CategoryIcon({super.key, required this.category, this.size = 42});

  static const Map<String, Color> _tints = {
    'Groceries': Color(0xFF6FCF97),
    'Dining': Color(0xFFE07A5F),
    'Transport': Color(0xFF56A3D9),
    'Shopping': Color(0xFFCBA25F),
    'Bills & Utilities': Color(0xFF9B7FD4),
    'Entertainment': Color(0xFFE0559F),
    'Health': Color(0xFFE0555F),
    'Travel': Color(0xFF4FC3C0),
    'Subscriptions': Color(0xFFB89152),
    'Other': Color(0xFF8A90A3),
  };

  @override
  Widget build(BuildContext context) {
    final spec = SpendCategory.byName(category);
    final tint = _tints[category] ?? AppColors.brass;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: tint.withOpacity(0.15),
        borderRadius: BorderRadius.circular(size * 0.32),
      ),
      child: Icon(spec.icon, color: tint, size: size * 0.5),
    );
  }
}

Color categoryColor(String category) =>
    CategoryIcon._tints[category] ?? AppColors.brass;
