import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../state/app_scope.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/credit_card_widget.dart';
import '../widgets/spending_donut.dart';
import '../widgets/transaction_tile.dart';
import 'add_transaction_screen.dart';

class CardDetailScreen extends StatelessWidget {
  final String cardId;
  const CardDetailScreen({super.key, required this.cardId});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);

    return Scaffold(
      body: AnimatedBuilder(
        animation: state,
        builder: (context, _) {
          if (!state.cards.any((c) => c.id == cardId)) {
            return const SizedBox.shrink();
          }
          final card = state.cardById(cardId);
          final txns = state.transactionsForCurrentCycle(cardId);
          final breakdown = state.categoryBreakdown(cardId);

          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 0),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        _backButton(context),
                        const Spacer(),
                        _deleteButton(context, state, card),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
                  sliver: SliverToBoxAdapter(
                    child: Hero(tag: 'card_${card.id}', child: CreditCardWidget(card: card)),
                  ),
                ),
                SliverToBoxAdapter(child: const SizedBox(height: AppSpacing.lg)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  sliver: SliverToBoxAdapter(child: _statementPanel(context, card)),
                ),
                SliverToBoxAdapter(child: const SizedBox(height: AppSpacing.lg)),
                if (card.isCredit)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    sliver: SliverToBoxAdapter(child: _utilizationPanel(context, card)),
                  ),
                if (card.isCredit) SliverToBoxAdapter(child: const SizedBox(height: AppSpacing.lg)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceRaised,
                        borderRadius: BorderRadius.circular(AppRadii.tile),
                        border: Border.all(color: AppColors.hairline),
                      ),
                      child: SpendingDonut(data: breakdown),
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: const SizedBox(height: AppSpacing.xl)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('This statement', style: Theme.of(context).textTheme.titleLarge),
                        Text('${txns.length} transactions',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 140),
                  sliver: txns.isEmpty
                      ? SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Text('No transactions this cycle yet.',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, i) {
                              if (i.isOdd) {
                                return const Divider(height: 1, color: AppColors.hairline);
                              }
                              return TransactionTile(txn: txns[i ~/ 2]);
                            },
                            childCount: txns.length * 2 - 1,
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.brass,
        foregroundColor: const Color(0xFF14161C),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add expense', style: TextStyle(fontWeight: FontWeight.w700)),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AddTransactionScreen(initialCardId: cardId)),
        ),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surfaceRaised,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.hairline),
        ),
        child: const Icon(Icons.arrow_back_rounded, color: AppColors.ivory, size: 20),
      ),
    );
  }

  Widget _deleteButton(BuildContext context, AppState state, CardModel card) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () => _confirmDelete(context, state, card),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surfaceRaised,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.hairline),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: AppColors.danger, size: 20),
      ),
    );
  }

  void _confirmDelete(BuildContext context, AppState state, CardModel card) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceRaised,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadii.tile)),
        title: const Text('Remove card?'),
        content: Text('${card.bank} •••${card.last4} and its transactions will be deleted.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              state.removeCard(card.id);
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Remove', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }

  Widget _statementPanel(BuildContext context, CardModel card) {
    final daysLeft = card.daysUntilDue;
    final urgent = card.isCredit && daysLeft <= 5;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceRaised,
        borderRadius: BorderRadius.circular(AppRadii.tile),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _statementField(
                  context,
                  label: 'Statement date',
                  value: formatDateFull(card.nextStatementDate),
                  caption: 'Closes on the ${formatDayOrdinal(card.statementDay)}',
                ),
              ),
              Container(width: 1, height: 40, color: AppColors.hairline),
              Expanded(
                child: _statementField(
                  context,
                  label: card.isCredit ? 'Payment due' : 'Cycle resets',
                  value: formatDateFull(card.nextDueDate),
                  caption: card.isCredit
                      ? '$daysLeft ${daysLeft == 1 ? 'day' : 'days'} left'
                      : 'Every ${formatDayOrdinal(card.dueDay)}',
                  captionColor: urgent ? AppColors.negative : null,
                  alignEnd: true,
                ),
              ),
            ],
          ),
          if (card.isCredit) ...[
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppColors.hairline),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _amountBlock(context, 'Total balance', formatCurrency(card.currentBalance)),
                _amountBlock(context, 'Minimum due', formatCurrency(card.minimumDue)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _statementField(
    BuildContext context, {
    required String label,
    required String value,
    required String caption,
    Color? captionColor,
    bool alignEnd = false,
  }) {
    return Column(
      crossAxisAlignment: alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 6),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontFeatures: const [FontFeature.tabularFigures()])),
        const SizedBox(height: 4),
        Text(caption,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: captionColor ?? AppColors.brass,
            )),
      ],
    );
  }

  Widget _amountBlock(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.ivory,
              fontFeatures: [FontFeature.tabularFigures()],
            )),
      ],
    );
  }

  Widget _utilizationPanel(BuildContext context, CardModel card) {
    final pct = card.utilization;
    final over80 = pct >= 0.8;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceRaised,
        borderRadius: BorderRadius.circular(AppRadii.tile),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Credit utilization', style: Theme.of(context).textTheme.titleMedium),
              Text(
                '${(pct * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: over80 ? AppColors.negative : AppColors.brass,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 8,
              backgroundColor: AppColors.hairline,
              valueColor: AlwaysStoppedAnimation(
                over80 ? AppColors.negative : AppColors.brass,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${formatCurrency(card.currentBalance)} of ${formatCurrency(card.creditLimit ?? 0)} limit',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
