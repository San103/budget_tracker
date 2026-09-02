const List<String> _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String formatCurrency(double amount, {String symbol = '₱', bool showSign = false}) {
  final isNegative = amount < 0;
  final value = amount.abs();
  final fixed = value.toStringAsFixed(2);
  final parts = fixed.split('.');
  final intPart = parts[0];
  final buffer = StringBuffer();
  for (int i = 0; i < intPart.length; i++) {
    final posFromEnd = intPart.length - i;
    buffer.write(intPart[i]);
    if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write(',');
  }
  final sign = isNegative ? '-' : (showSign ? '+' : '');
  return '$sign$symbol${buffer.toString()}.${parts[1]}';
}

String formatCompact(double amount) {
  if (amount.abs() >= 1000000) {
    return '${(amount / 1000000).toStringAsFixed(1)}M';
  }
  if (amount.abs() >= 1000) {
    return '${(amount / 1000).toStringAsFixed(1)}K';
  }
  return amount.toStringAsFixed(0);
}

String formatDateFull(DateTime d) => '${_months[d.month - 1]} ${d.day}, ${d.year}';

String formatDateShort(DateTime d) => '${_months[d.month - 1]} ${d.day}';

String _ordinal(int day) {
  if (day >= 11 && day <= 13) return '${day}th';
  switch (day % 10) {
    case 1:
      return '${day}st';
    case 2:
      return '${day}nd';
    case 3:
      return '${day}rd';
    default:
      return '${day}th';
  }
}

String formatDayOrdinal(int day) => _ordinal(day);

String formatMonthYear(DateTime d) => '${_months[d.month - 1]} ${d.year}';
