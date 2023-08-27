// Properties of a finance item
class FinanceItem {
  final List<String> participants;

  // date of transaction
  final int dateYear;
  final int dateMonth;
  final int dateDay;

  final String desc;
  final double amount;

  // AA, %, exact amount, no split
  final String splitOption;

  // type of transaction (income or expense)
  final String type;

  final String? category;
  String? goal;
  final String currency;

  FinanceItem({
    required this.participants,
    required this.dateMonth,
    required this.dateDay,
    required this.dateYear,
    required this.desc,
    required this.amount,
    required this.type,
    required this.category,
    this.goal = '-',
    required this.currency,
    required this.splitOption,
  });

  // convert data for database
  toJson() {
    return {
      "participants": participants,
      "dateMonth": dateMonth,
      "dateDay": dateDay,
      "dateYear": dateYear,
      "type": type,
      "category": category,
      "goal": goal,
      "desc": desc,
      "currency": currency,
      "amount": amount,
      "splitOption": splitOption,
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
}
