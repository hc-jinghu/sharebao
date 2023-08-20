// Properties of a finance item in a finance list
class FinanceItem {
  final List<String> participants;

  // date of transaction
  final int dateMonth;
  final int dateDay;

  final String desc;
  final double amount;

  // AA, %, exact amount, no split
  final String splitOption;
  final bool isTempPay;

  // type of transaction (income or expense)
  final String type;

  final String category;
  final String currency;

  FinanceItem({
    required this.participants,
    required this.dateMonth,
    required this.dateDay,
    required this.desc,
    required this.amount,
    required this.type,
    required this.category,
    required this.currency,
    required this.splitOption,
    this.isTempPay = false,
  });

  // convert data for database
  toJson() {
    return {
      "participants": participants,
      "dateMonth": dateMonth,
      "dateDay": dateDay,
      "type": type,
      "category": category,
      "desc": desc,
      "currency": currency,
      "amount": amount,
      "splitOption": splitOption,
      "isTempPay": isTempPay,
    };
  }

  // get number of participated users
  int getParticipants() {
    return participants.length;
  }

  // get participated user
  String getParticipant(String user) {
    return participants[int.parse(user)];
  }

  // set/change current participated user
  String setParticipant(String user, String newUser) {
    return participants[int.parse(user)] = newUser;
  }

  // add participated user
  void addParticipant(String newUser) {
    for (var user in participants) {
      if (newUser != user) {
        participants.add(newUser);
      }
    }
  }

  // get weekday from a dateTime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
