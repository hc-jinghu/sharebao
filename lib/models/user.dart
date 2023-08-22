// Properties of a registered user

class User {
  final String name;
  Map<String, double>
      tempPayment; // <user docId, amount paid> e.g p1 owes you xxx
  Map<String, double>
      splitPayment; // <user docId, amount owed> e.g. You owe p2 xxx

  User({
    required this.name,
    this.tempPayment = const {},
    this.splitPayment = const {},
  });

  toJson() {
    return {
      "name": name,
      "tempPayment": tempPayment,
      "splitPayment": splitPayment,
    };
  }

  // get total temp payment
  double getTotalTemp() {
    var values = tempPayment.values;
    return values.fold(0.0, (sum, value) => sum + value);
  }

  // get total split payment
  double getTotalSplit() {
    var values = splitPayment.values;
    return values.fold(0.0, (sum, value) => sum + value);
  }
}
