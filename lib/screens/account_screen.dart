import 'package:flutter/material.dart';

import '../state/app_scope.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/credit_card_widget.dart';
import '../widgets/stat_pill.dart';
import '../widgets/transaction_tile.dart';
import 'card_detail_screen.dart';
import 'add_transaction_screen.dart';
import 'add_card_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.86);
  int _activePage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final cards = state.cards;

    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: state,
          builder: (context, _) {
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    0,
                  ),
                  sliver: SliverToBoxAdapter(child: _header(context)),
                ),
                SliverToBoxAdapter(
                  child: const SizedBox(height: AppSpacing.lg),
                ),
                SliverToBoxAdapter(
                  child: cards.isEmpty
                      ? _emptyCardsState(context)
                      : _cardCarousel(context, cards.length),
                ),
                if (cards.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: const SizedBox(height: AppSpacing.sm),
                  ),
                  SliverToBoxAdapter(child: _pageDots(cards.length)),
                ],
                SliverToBoxAdapter(
                  child: const SizedBox(height: AppSpacing.lg),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  sliver: SliverToBoxAdapter(child: _statsRow(context, state)),
                ),
                SliverToBoxAdapter(
                  child: const SizedBox(height: AppSpacing.xl),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'Recent activity',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    120,
                  ),
                  sliver: state.recentTransactions.isEmpty
                      ? SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Text(
                              'No transactions yet.',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate((context, i) {
                            if (i.isOdd) {
                              return const Divider(
                                height: 1,
                                color: AppColors.hairline,
                              );
                            }
                            final txn = state.recentTransactions[i ~/ 2];
                            final card = state.cardById(txn.cardId);
                            return TransactionTile(
                              txn: txn,
                              subtitle:
                                  '${card.bank} •••${card.last4} · ${formatDateShort(txn.date)}',
                            );
                          }, childCount: state.recentTransactions.length * 2 - 1),
                        ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: cards.isEmpty
          ? null
          : FloatingActionButton.extended(
              backgroundColor: AppColors.brass,
              foregroundColor: const Color(0xFF14161C),
              icon: const Icon(Icons.add_rounded),
              label: const Text(
                'Add expense',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
              ),
            ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_greeting(), style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 2),
            Text(
              'Your wallet',
              style: Theme.of(context).textTheme.displayLarge
                  ?.copyWith(fontSize: 30),
            ),
          ],
        ),
        InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddCardScreen())),
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.surfaceRaised,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.hairline),
            ),
            child: const Icon(
              Icons.add_card_rounded,
              color: AppColors.brass,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 18) return 'Good afternoon';
    return 'Good evening';
  }

  Widget _cardCarousel(BuildContext context, int count) {
    return SizedBox(
      height: 210,
      child: PageView.builder(
        controller: _pageController,
        itemCount: count,
        onPageChanged: (i) => setState(() => _activePage = i),
        itemBuilder: (context, index) {
          final state = AppScope.of(context);
          final card = state.cards[index];
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double scale = 1.0;
              if (_pageController.hasClients &&
                  _pageController.position.haveDimensions) {
                final page = _pageController.page ?? _activePage.toDouble();
                scale = (1 - ((page - index).abs() * 0.08)).clamp(0.9, 1.0);
              }
              return Transform.scale(scale: scale, child: child);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CardDetailScreen(cardId: card.id),
                  ),
                ),
                child: Hero(
                  tag: 'card_${card.id}',
                  child: CreditCardWidget(card: card),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _pageDots(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == _activePage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 18 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: active ? AppColors.brass : AppColors.hairline,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _emptyCardsState(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surfaceRaised,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.credit_card_off_rounded,
            color: AppColors.ivoryFaint,
            size: 36,
          ),
          const SizedBox(height: 12),
          Text('No cards yet', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(
            'Add a debit or credit card to start tracking.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 18),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.brass,
              foregroundColor: const Color(0xFF14161C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadii.button),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const AddCardScreen())),
            child: const Text(
              'Add a card',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statsRow(BuildContext context, AppState state) {
    return Row(
      children: [
        Expanded(
          child: StatPill(
            label: 'Total Credit Limit',
            value: formatCurrency(state.totalOutstanding),
            icon: Icons.account_balance_wallet_rounded,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatPill(
            label: 'Spent this cycle',
            value: formatCurrency(state.totalSpentThisCycle),
            icon: Icons.trending_up_rounded,
            accent: AppColors.positive,
          ),
        ),
      ],
    );
  }
}
