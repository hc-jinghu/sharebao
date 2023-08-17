// Properties of a finance item in a finance list
class FinanceItem {
  // TODO: add other properties
  final String dateMonth;
  final String dateDay;
  final String desc;
  final double amount;
  final String type;

  FinanceItem({
    required this.dateMonth,
    required this.dateDay,
    required this.desc,
    required this.amount,
    required this.type,
  });
}
