import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AvailableToSpent extends StatelessWidget {
  const AvailableToSpent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.brass,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'AVAILABLE TO SPEND',
                style: TextStyle(
                  color: AppColors.ivoryFaint,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          const Text(
            '₱7,850.00',
            style: TextStyle(
              color: AppColors.ivory,
              fontSize: 36,
              fontWeight: FontWeight.w600,
              letterSpacing: -1.2,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(
                Icons.check_circle_outline_rounded,
                color: AppColors.positive,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'You are on track this month',
                style: TextStyle(color: AppColors.ivoryMuted, fontSize: 12.5),
              ),
            ],
          ),

          const SizedBox(height: 20),

          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: const LinearProgressIndicator(
              value: 0.72,
              minHeight: 5,
              backgroundColor: AppColors.hairline,
              valueColor: AlwaysStoppedAnimation(AppColors.brass),
            ),
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₱30,000 income',
                style: TextStyle(color: AppColors.ivoryFaint, fontSize: 11),
              ),
              Text(
                '₱18,450 spent',
                style: TextStyle(color: AppColors.ivoryFaint, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
