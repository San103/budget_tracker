import 'package:budget_tracker/database/app_database.dart';
import 'package:budget_tracker/models/card_model.dart';
import 'package:budget_tracker/screens/add_card_screen.dart';
import 'package:budget_tracker/screens/add_transaction_screen.dart';
import 'package:budget_tracker/screens/account_screen.dart';
import 'package:budget_tracker/state/app_scope.dart';
import 'package:budget_tracker/utils/formatters.dart';
import 'package:budget_tracker/widgets/available_to_spent.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);

    final List<Account> accounts = state.accounts;

    final List<Account> creditAccounts = state.creditCards;
    // final transactions = state.transactions;

    double income = state.income;
    double expenses = state.expenses;
    double availableToSpend = state.income - state.expenses;

    // final accounts = [
    //   const _Account(
    //     name: 'Maya',
    //     type: 'E-Wallet',
    //     balance: 5000,
    //     paletteIndex: 1,
    //     icon: Icons.account_balance_wallet_rounded,
    //   ),
    //   const _Account(
    //     name: 'GCash',
    //     type: 'E-Wallet',
    //     balance: 2450,
    //     paletteIndex: 5,
    //     icon: Icons.account_balance_wallet_rounded,
    //   ),
    //   const _Account(
    //     name: 'BPI',
    //     type: 'E-Wallet',
    //     balance: 2450,
    //     paletteIndex: 3,
    //     icon: Icons.account_balance_wallet_rounded,
    //   ),
    // ];
    // final creditAccounts = [
    //   const _Account(
    //     name: 'PNB',
    //     type: 'Credit Card',
    //     balance: 12450,
    //     limit: 25000,
    //     paletteIndex: 0,
    //     icon: Icons.credit_card_rounded,
    //   ),
    //   const _Account(
    //     name: 'UnionBank',
    //     type: 'Credit Card',
    //     balance: 5000,
    //     limit: 35000,
    //     paletteIndex: 4,
    //     icon: Icons.credit_card_rounded,
    //   ),
    // ];

    final transactions = [
      const _Transaction(
        title: 'Salary',
        category: 'Income',
        amount: 30000,
        icon: Icons.arrow_downward_rounded,
        isIncome: true,
      ),
      const _Transaction(
        title: 'Groceries',
        category: 'Food & Grocery',
        amount: -850,
        icon: Icons.shopping_cart_outlined,
      ),
      const _Transaction(
        title: 'Electric Bill',
        category: 'Utilities',
        amount: -1850,
        icon: Icons.bolt_outlined,
      ),
      const _Transaction(
        title: 'Lunch',
        category: 'Dining',
        amount: -250,
        icon: Icons.restaurant_outlined,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.xxl,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildHeader(context),

                  const SizedBox(height: AppSpacing.lg),
                  AvailableToSpent(availableToSpend: availableToSpend),
                  const SizedBox(height: AppSpacing.lg),

                  _buildIncomeExpense(income: income, expenses: expenses),

                  const SizedBox(height: AppSpacing.xl),

                  _buildSectionHeader(
                    context: context,
                    title: 'Debit / E-wallet Accounts',
                    action: 'Manage',
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  _buildAccounts(accounts, type: CardType.debit),

                  const SizedBox(height: AppSpacing.xl),

                  _buildSectionHeader(
                    context: context,
                    title: 'Credit Card Accounts',
                    action: 'Manage',
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  _buildAccounts(creditAccounts, type: CardType.credit),

                  const SizedBox(height: AppSpacing.xl),

                  _buildSectionHeader(
                    context: context,
                    title: 'Recent transactions',
                    action: 'See all',
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  _buildTransactions(context, transactions),
                ]),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AddTransactionScreen(initialCardId: ''),
          ),
        ),
        backgroundColor: AppColors.brass,
        foregroundColor: AppColors.canvas,
        elevation: 4,
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------------

  Widget _buildHeader(BuildContext context) {
    final appState = AppScope.of(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 3),
              Text(
                'Your Wallet',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),

        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadii.button),
            onTap: appState.toggleTheme,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: context.colors.surfaceRaised,
                borderRadius: BorderRadius.circular(AppRadii.button),
                border: Border.all(color: context.colors.hairline),
              ),
              child: Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                color: context.colors.ivoryMuted,
                size: 21,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: context.colors.surfaceRaised,
            borderRadius: BorderRadius.circular(AppRadii.button),
            border: Border.all(color: context.colors.hairline),
          ),
          child: Icon(
            Icons.notifications_none_rounded,
            color: context.colors.ivoryMuted,
            size: 21,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // AVAILABLE TO SPEND
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  // INCOME / EXPENSE
  // ---------------------------------------------------------------------------

  Widget _buildIncomeExpense({
    required double income,
    required double expenses,
  }) {
    return Row(
      children: [
        Expanded(
          child: _MoneyTile(
            title: 'Income',
            amount: income,
            icon: Icons.arrow_downward_rounded,
            iconColor: AppColors.positive,
          ),
        ),

        const SizedBox(width: AppSpacing.sm),

        Expanded(
          child: _MoneyTile(
            title: 'Expenses',
            amount: expenses,
            icon: Icons.arrow_upward_rounded,
            iconColor: AppColors.negative,
          ),
        ),
      ],
    );
  }
  // ---------------------------------------------------------------------------
  // ACCOUNTS
  // ---------------------------------------------------------------------------

  Widget _buildAccounts(List<Account> accounts, {required CardType type}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = AppSpacing.sm;

        // 1 column on narrow phones, 2 columns on normal phones/tablets.
        final isNarrow = constraints.maxWidth < 360;
        final columns = isNarrow ? 1 : 2;

        final itemWidth = columns == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - spacing) / 2;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            ...accounts.map((account) {
              return SizedBox(
                width: itemWidth,
                height: 150,
                child: _AccountCard(account: account),
              );
            }),

            // Add Card
            SizedBox(
              width: itemWidth,
              height: 150,
              child: _AddCardTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCardScreen(type: type),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // TRANSACTIONS
  // ---------------------------------------------------------------------------

  Widget _buildTransactions(
    BuildContext context,
    List<_Transaction> transactions,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppRadii.tile),
        border: Border.all(color: context.colors.hairline),
      ),
      child: Column(
        children: [
          for (int i = 0; i < transactions.length; i++) ...[
            _TransactionTile(transaction: transactions[i]),

            if (i != transactions.length - 1)
              const Divider(height: 1, indent: 68, endIndent: 16),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION HEADER
  // ---------------------------------------------------------------------------

  Widget _buildSectionHeader({
    required BuildContext context,
    required String title,
    required String action,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: context.colors.ivory,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AccountScreen()),
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColors.brass,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            action,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// MONEY TILE
// =============================================================================

class _MoneyTile extends StatelessWidget {
  final String title;
  final double amount;
  final IconData icon;
  final Color iconColor;

  const _MoneyTile({
    required this.title,
    required this.amount,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppRadii.tile),
        border: Border.all(color: context.colors.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: context.colors.ivoryMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            formatCurrency(amount),
            style: TextStyle(
              color: context.colors.ivory,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// ACCOUNT CARD
// =============================================================================

class _AccountCard extends StatelessWidget {
  final Account account;

  const _AccountCard({required this.account});

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.cardPalettes[account.paletteIndex];

    return Container(
      width: 190,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: palette.first,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.access_alarm_outlined,
                color: Colors.white.withValues(alpha: 0.85),
                size: 22,
              ),
              Text(
                account.type == 'Credit Card' ? 'CREDIT' : 'E-WALLET',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            account.name,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            '₱${account.balance.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ),

          if (account.creditLimit != null) ...[
            const SizedBox(height: 5),
            Text(
              '₱${account.creditLimit!.toStringAsFixed(0)} limit',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// =============================================================================
// TRANSACTION TILE
// =============================================================================

class _TransactionTile extends StatelessWidget {
  final _Transaction transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 12,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: context.colors.surfaceRaised,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              transaction.icon,
              color: transaction.isIncome
                  ? AppColors.positive
                  : context.colors.ivoryMuted,
              size: 19,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: TextStyle(
                    color: context.colors.ivory,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.category,
                  style: TextStyle(
                    color: context.colors.ivoryFaint,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          Text(
            '${transaction.isIncome ? '+' : '-'}₱${transaction.amount.abs().toStringAsFixed(2)}',
            style: TextStyle(
              color: transaction.isIncome
                  ? AppColors.positive
                  : context.colors.ivory,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// MODELS — SAMPLE ONLY
// =============================================================================

class _Transaction {
  final String title;
  final String category;
  final double amount;
  final IconData icon;
  final bool isIncome;

  const _Transaction({
    required this.title,
    required this.category,
    required this.amount,
    required this.icon,
    this.isIncome = false,
  });
}

class _AddCardTile extends StatelessWidget {
  final VoidCallback onTap;

  const _AddCardTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(
              color: Colors.grey.withValues(alpha: 0.25),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, size: 24, color: Colors.grey),
              ),

              const SizedBox(height: AppSpacing.sm),

              const Text(
                'Add Card',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 3),

              Text(
                'Add a credit or debit card',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
