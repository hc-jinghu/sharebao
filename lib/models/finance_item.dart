// Properties of a finance item in a finance list
class FinanceItem {
  // date of transaction
  final int dateMonth;
  final int dateDay;

  final String desc;
  final double amount;

  // a percentage or amount or no split. (AA, 20% 80%, joint account)
  final double split;
  final String tempPay;

  // type of transaction (income or expense)
  final String type;

  final String category;
  final String currency;

  FinanceItem({
    required this.dateMonth,
    required this.dateDay,
    required this.desc,
    required this.amount,
    required this.split,
    required this.tempPay,
    required this.type,
    required this.category,
    required this.currency,
  });

  // convert data for database
  toJson() {
    return {
      "dateMonth": dateMonth,
      "dateDay": dateDay,
      "type": type,
      "category": category,
      "desc": desc,
      "currency": currency,
      "amount": amount,
      "split": split,
      "tempPay": tempPay,
    };
  }
}
