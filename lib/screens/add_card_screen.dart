import 'package:flutter/material.dart';

import '../models/card_model.dart';
import '../state/app_scope.dart';
import '../theme/app_theme.dart';
import '../widgets/credit_card_widget.dart';

class AddCardScreen extends StatefulWidget {
  final CardType type;
  const AddCardScreen({super.key, required this.type});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _bankController = TextEditingController();
  final _holderController = TextEditingController(text: 'Alex Rivera');
  final _last4Controller = TextEditingController();
  final _limitController = TextEditingController();
  final _balanceController = TextEditingController(text: '0');

  // CardType _type = CardType.credit;
  CardNetwork _network = CardNetwork.visa;
  int _expiryMonth = DateTime.now().month;
  int _expiryYear = DateTime.now().year + 3;
  int _statementDay = 1;
  int _dueDay = 20;
  int _paletteIndex = 0;

  @override
  void dispose() {
    _bankController.dispose();
    _holderController.dispose();
    _last4Controller.dispose();
    _limitController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  String _safeLast4() {
    final digits = _last4Controller.text.trim();
    if (digits.isEmpty) return '0000';
    return digits.padLeft(4, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a card'),
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
            // AnimatedBuilder(
            //   animation: Listenable.merge([
            //     _bankController,
            //     _holderController,
            //     _last4Controller,
            //   ]),
            //   builder: (context, _) => CreditCardWidget(card: _previewCard),
            // ),
            const SizedBox(height: 28),
            _label(context, 'Card color'),
            const SizedBox(height: 10),
            _paletteSelector(),
            // _label(context, 'Card type'),
            // const SizedBox(height: 10),
            _typeToggle(),
            const SizedBox(height: 24),
            _label(context, 'Bank / issuer'),
            const SizedBox(height: 10),
            _field(context, _bankController, hint: 'e.g. Meridian Bank'),
            const SizedBox(height: 20),
            _label(context, 'Cardholder name'),
            const SizedBox(height: 10),
            _field(context, _holderController, hint: 'e.g. Alex Rivera'),
            const SizedBox(height: 20),
            _label(context, 'Last 4 digits'),
            const SizedBox(height: 10),
            _field(
              context,
              _last4Controller,
              hint: '4821',
              maxLength: 4,
              numeric: true,
            ),
            const SizedBox(height: 20),
            _label(context, 'Network'),
            const SizedBox(height: 10),
            _networkSelector(),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _label(context, 'Expiry month')),
                Expanded(child: _label(context, 'Expiry year')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _monthDropdown()),
                const SizedBox(width: 12),
                Expanded(child: _yearDropdown()),
              ],
            ),

            if (widget.type == CardType.credit) ...[
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _label(context, 'Statement day')),
                  Expanded(child: _label(context, 'Due day')),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _dayDropdown(
                      _statementDay,
                      (v) => setState(() => _statementDay = v),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _dayDropdown(
                      _dueDay,
                      (v) => setState(() => _dueDay = v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _label(context, 'Credit limit'),
              const SizedBox(height: 10),
              _field(
                context,
                _limitController,
                hint: '5000',
                numeric: true,
                isAmount: true,
              ),
              const SizedBox(height: 20),
              _label(context, 'Current outstanding balance'),
              const SizedBox(height: 10),
              _field(
                context,
                _balanceController,
                hint: '0',
                numeric: true,
                isAmount: true,
              ),
            ],
            // else ...[
            //   const SizedBox(height: 20),
            //   _label(context, 'Spent this cycle'),
            //   const SizedBox(height: 10),
            //   _field(
            //     context,
            //     _balanceController,
            //     hint: '0',
            //     numeric: true,
            //     isAmount: true,
            //   ),
            // ],
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
              onPressed: _submit,
              child: const Text(
                'Save card',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(BuildContext context, String text) =>
      Text(text, style: Theme.of(context).textTheme.titleMedium);

  Widget _field(
    BuildContext context,
    TextEditingController controller, {
    required String hint,
    int? maxLength,
    bool numeric = false,
    bool isAmount = false,
  }) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      onChanged: (_) => setState(() {}),
      keyboardType: numeric
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      style: TextStyle(
        fontSize: 16,
        color: context.colors.ivory,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        counterText: '',
        prefixText: isAmount ? '\$ ' : null,
        hintText: hint,
        hintStyle: TextStyle(color: context.colors.ivoryFaint),
        filled: true,
        fillColor: context.colors.surfaceRaised,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.button),
          borderSide: BorderSide(color: context.colors.hairline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.button),
          borderSide: BorderSide(color: context.colors.hairline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.button),
          borderSide: const BorderSide(color: AppColors.brass, width: 1.5),
        ),
      ),
    );
  }

  Widget _typeToggle() {
    return Container();
    // return Container(
    //   padding: const EdgeInsets.all(4),
    //   decoration: BoxDecoration(
    //     color: AppColors.surfaceRaised,
    //     borderRadius: BorderRadius.circular(AppRadii.pill),
    //     border: Border.all(color: AppColors.hairline),
    //   ),
    //   child: Row(
    //     children: [
    //       _toggleOption(
    //         'Credit',
    //         widget.type == CardType.credit,
    //         () => setState(() => widget.type = CardType.credit),
    //       ),
    //       _toggleOption(
    //         'Debit',
    //         widget.type == CardType.debit,
    //         () => setState(() => widget.type = CardType.debit),
    //       ),
    //     ],
    //   ),
    // );
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
              color: selected ? const Color(0xFF14161C) : AppColors.ivoryMuted,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _networkSelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: CardNetwork.values.map((n) {
        final selected = n == _network;
        return InkWell(
          borderRadius: BorderRadius.circular(AppRadii.pill),
          onTap: () => setState(() => _network = n),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.brass.withOpacity(0.16)
                  : AppColors.surfaceRaised,
              borderRadius: BorderRadius.circular(AppRadii.pill),
              border: Border.all(
                color: selected ? AppColors.brass : AppColors.hairline,
              ),
            ),
            child: Text(
              n.label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: selected ? AppColors.brass : AppColors.ivory,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _monthDropdown() {
    return _dropdownShell(
      DropdownButton<int>(
        value: _expiryMonth,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: AppColors.surfaceRaised,
        style: const TextStyle(
          color: AppColors.ivory,
          fontWeight: FontWeight.w600,
        ),
        items: List.generate(12, (i) => i + 1)
            .map(
              (m) => DropdownMenuItem(
                value: m,
                child: Text(m.toString().padLeft(2, '0')),
              ),
            )
            .toList(),
        onChanged: (v) => setState(() => _expiryMonth = v ?? _expiryMonth),
      ),
    );
  }

  Widget _yearDropdown() {
    final years = List.generate(12, (i) => DateTime.now().year + i);
    return _dropdownShell(
      DropdownButton<int>(
        value: _expiryYear,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: AppColors.surfaceRaised,
        style: const TextStyle(
          color: AppColors.ivory,
          fontWeight: FontWeight.w600,
        ),
        items: years
            .map((y) => DropdownMenuItem(value: y, child: Text(y.toString())))
            .toList(),
        onChanged: (v) => setState(() => _expiryYear = v ?? _expiryYear),
      ),
    );
  }

  Widget _dayDropdown(int value, ValueChanged<int> onChanged) {
    return _dropdownShell(
      DropdownButton<int>(
        value: value,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: AppColors.surfaceRaised,
        style: const TextStyle(
          color: AppColors.ivory,
          fontWeight: FontWeight.w600,
        ),
        items: List.generate(28, (i) => i + 1)
            .map((d) => DropdownMenuItem(value: d, child: Text('Day $d')))
            .toList(),
        onChanged: (v) => onChanged(v ?? value),
      ),
    );
  }

  Widget _dropdownShell(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceRaised,
        borderRadius: BorderRadius.circular(AppRadii.button),
        border: Border.all(color: AppColors.hairline),
      ),
      child: child,
    );
  }

  Widget _paletteSelector() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: AppColors.cardPalettes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final palette = AppColors.cardPalettes[i];
          final selected = i == _paletteIndex;
          return InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () => setState(() => _paletteIndex = i),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: palette,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: selected ? AppColors.brass : Colors.transparent,
                  width: 2.5,
                ),
              ),
              child: selected
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 18,
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }

  void _submit() {
    if (_bankController.text.trim().isEmpty ||
        _last4Controller.text.trim().length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a bank name and 4-digit card number.'),
        ),
      );
      return;
    }

    //  bank: bank,
    //     name: name,
    //     type: type,
    //     balance: Value(balance),
    //     creditLimit: Value(creditLimit),
    //     lastDigit: Value(lastDigit),
    //     network: network,
    //     expiryMonth: Value(expiryMonth),
    //     expiryYear: Value(expiryYear),
    //     statementDay: Value(statementDay),
    //     dueDay: Value(dueDay),
    //     paletteIndex: Value(paletteIndex),
    //     icon: icon,

    final state = AppScope.of(context);
    state.addCard(
      CardModel(
        bank: _bankController.text.trim(),
        name: _holderController.text.trim().isEmpty
            ? 'Card Holder'
            : _holderController.text.trim(),
        type: widget.type,
        lastDigit: int.parse(_last4Controller.text.trim()),
        network: _network,
        expiryMonth: _expiryMonth,
        expiryYear: _expiryYear,
        creditLimit: widget.type == CardType.credit
            ? (double.tryParse(_limitController.text) ?? 0)
            : null,
        balance: double.tryParse(_balanceController.text) ?? 0,
        statementDay: _statementDay,
        dueDay: _dueDay,
        palettteIndex: _paletteIndex,
        icon: '',
      ),
    );
    Navigator.pop(context);
  }
}
