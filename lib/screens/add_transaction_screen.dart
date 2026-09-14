import 'package:budget_tracker/widgets/dashed_border.dart';
import 'package:flutter/material.dart';

import '../models/card_model.dart';
import '../models/transaction_model.dart';
import '../state/app_scope.dart';
import '../theme/app_theme.dart';

class AddTransactionScreen extends StatefulWidget {
  final String? initialCardId;
  const AddTransactionScreen({super.key, this.initialCardId});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedCardId;
  String _selectedCategory = SpendCategory.all.first.name;
  DateTime _selectedDate = DateTime.now();
  bool _isCredit = false;

  @override
  void initState() {
    super.initState();
    _selectedCardId = widget.initialCardId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final cards = state.cards;
    final cardList = _isCredit ? state.creditCards : state.debitCards;
    _selectedCardId ??= cards.isNotEmpty ? cards.first.id : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            140,
          ),
          children: [
            _sectionLabel(context, 'Transaction Type'),
            const SizedBox(height: 10),
            _typeToggle(),
            const SizedBox(height: 24),
            _sectionLabel(context, 'Card', optional: ' (optional)'),
            const SizedBox(height: 10),
            // _cardSelector(context, cardList),
            const SizedBox(height: 24),
            _sectionLabel(context, 'Amount'),
            const SizedBox(height: 10),
            _textField(_amountController, hint: '0.00', isAmount: true),
            const SizedBox(height: 24),

            _sectionLabel(context, 'Description', optional: ' (optional)'),
            const SizedBox(height: 10),
            _textField(
              _titleController,
              hint:
                  'e.g. ${_isCredit ? "Friend Payment" : "Whole Foods Market"}',
            ),
            const SizedBox(height: 24),

            _sectionLabel(context, 'Category'),
            const SizedBox(height: 10),
            _categoryGrid(_isCredit),
            const SizedBox(height: 24),
            _sectionLabel(context, 'Date'),
            const SizedBox(height: 10),
            _dateSelector(context),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.brass,
                foregroundColor: const Color(0xFF14161C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.button),
                ),
              ),
              onPressed: cards.isEmpty ? null : _submit,
              child: const Text(
                'Save expense',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(BuildContext context, String text, {String? optional}) {
    final style = Theme.of(context).textTheme.titleMedium;

    return RichText(
      text: TextSpan(
        style: style,
        children: [
          TextSpan(text: text),
          if (optional != null)
            TextSpan(
              text: ' $optional',
              style: style?.copyWith(
                fontSize: 12,
                color: AppColors.ivoryMuted,
                fontWeight: FontWeight.normal,
              ),
            ),
        ],
      ),
    );
  }

  Widget _cardSelector(BuildContext context, List<CardModel> cards) {
    return Container();
    // return SizedBox(
    //   height: 56,
    //   child: ListView.separated(
    //     scrollDirection: Axis.horizontal,
    //     itemCount: cards.length + 1,
    //     separatorBuilder: (_, __) => const SizedBox(width: 10),
    //     itemBuilder: (context, i) {
    //       // Add Card button
    //       if (i == cards.length) {
    //         return InkWell(
    //           borderRadius: BorderRadius.circular(AppRadii.pill),
    //           onTap: () {},
    //           child: CustomPaint(
    //             painter: DashedBorderPainter(
    //               color: AppColors.hairline,
    //               radius: AppRadii.pill,
    //             ),
    //             child: Container(
    //               padding: const EdgeInsets.symmetric(horizontal: 16),
    //               alignment: Alignment.center,
    //               child: Row(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   Icon(Icons.add, size: 18, color: AppColors.brass),
    //                   const SizedBox(width: 6),
    //                   Text(
    //                     'Add Card',
    //                     style: TextStyle(
    //                       color: AppColors.brass,
    //                       fontWeight: FontWeight.w600,
    //                       fontSize: 13.5,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         );
    //       }

    //       final card = cards[i];
    //       final selected = card.id == _selectedCardId;

    //       return InkWell(
    //         borderRadius: BorderRadius.circular(AppRadii.pill),
    //         onTap: () => setState(() => _selectedCardId = card.id),
    //         child: Container(
    //           padding: const EdgeInsets.symmetric(horizontal: 16),
    //           alignment: Alignment.center,
    //           decoration: BoxDecoration(
    //             color: selected
    //                 ? AppColors.brass.withOpacity(0.16)
    //                 : AppColors.surfaceRaised,
    //             borderRadius: BorderRadius.circular(AppRadii.pill),
    //             border: Border.all(
    //               color: selected ? AppColors.brass : AppColors.hairline,
    //               width: selected ? 1.5 : 1,
    //             ),
    //           ),
    //           child: Text(
    //             '${card.bank} •••${card.last4}',
    //             style: TextStyle(
    //               color: selected ? AppColors.brass : AppColors.ivory,
    //               fontWeight: FontWeight.w600,
    //               fontSize: 13.5,
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }

  Widget _typeToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colors.surfaceRaised,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: context.colors.hairline),
      ),
      child: Row(
        children: [
          _toggleOption(
            'Expense',
            !_isCredit,
            () => setState(() => _isCredit = false),
          ),
          _toggleOption(
            'Income',
            _isCredit,
            () => setState(() => _isCredit = true),
          ),
        ],
      ),
    );
  }

  Widget _toggleOption(String label, bool selected, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.pill),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.brass : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadii.pill),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected
                  ? const Color(0xFF14161C)
                  : context.colors.ivoryMuted,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField(
    TextEditingController controller, {
    required String hint,
    bool isAmount = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isAmount
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.ivory,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        prefixText: isAmount ? '₱ ' : null,
        prefixStyle: const TextStyle(
          fontSize: 16,
          color: AppColors.ivory,
          fontWeight: FontWeight.w600,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.ivoryFaint),
        filled: true,
        fillColor: AppColors.surfaceRaised,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.button),
          borderSide: const BorderSide(color: AppColors.hairline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.button),
          borderSide: const BorderSide(color: AppColors.hairline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.button),
          borderSide: const BorderSide(color: AppColors.brass, width: 1.5),
        ),
      ),
    );
  }

  Widget _categoryGrid(bool isCredit) {
    List<SpendCategory> categories = isCredit
        ? SpendCategory.income
        : SpendCategory.all;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: categories.map((cat) {
        final selected = cat.name == _selectedCategory;
        return InkWell(
          borderRadius: BorderRadius.circular(AppRadii.pill),
          onTap: () => setState(() => _selectedCategory = cat.name),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.brass.withOpacity(0.16)
                  : AppColors.surfaceRaised,
              borderRadius: BorderRadius.circular(AppRadii.pill),
              border: Border.all(
                color: selected ? AppColors.brass : AppColors.hairline,
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  cat.icon,
                  size: 15,
                  color: selected ? AppColors.brass : AppColors.ivoryMuted,
                ),
                const SizedBox(width: 6),
                Text(
                  cat.name,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: selected ? AppColors.brass : AppColors.ivory,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _dateSelector(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.button),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now(),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: AppColors.brass,
                surface: AppColors.surfaceRaised,
              ),
            ),
            child: child!,
          ),
        );
        if (picked != null) setState(() => _selectedDate = picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surfaceRaised,
          borderRadius: BorderRadius.circular(AppRadii.button),
          border: Border.all(color: AppColors.hairline),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_rounded,
              size: 18,
              color: AppColors.brass,
            ),
            const SizedBox(width: 10),
            Text(
              '${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}',
              style: const TextStyle(
                color: AppColors.ivory,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    // final title = _titleController.text.trim();
    // final amount = double.tryParse(_amountController.text.trim());

    // if (title.isEmpty ||
    //     amount == null ||
    //     amount <= 0 ||
    //     _selectedCardId == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Please fill in a description and a valid amount.'),
    //     ),
    //   );
    //   return;
    // }

    final state = AppScope.of(context);
    // required String id,
    // required String accountId,
    // required String type,
    // String? title,
    // required String category,
    // required double amount,
    // required DateTime date,

    state.addTransaction(
      // TransactionModel(
      //   id: 't_${DateTime.now().microsecondsSinceEpoch}',
      //   cardId: _selectedCardId!,
      //   title: title,
      //   category: _selectedCategory,
      //   amount: amount,
      //   date: _selectedDate,
      //   isCredit: _isCredit,
      // ),
    );
    Navigator.pop(context);
  }
}
