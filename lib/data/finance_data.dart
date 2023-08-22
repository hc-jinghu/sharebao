import 'dart:async';

import 'package:sharebao/const.dart';
import 'package:sharebao/models/finance_item.dart';

// TODO: category and currency should be a separate collection? document? in db
// add financeItem to db
Future addItem(
    List<String> participants,
    int dateMonth,
    int dateDay,
    int dateYear,
    String desc,
    double amount,
    String splitOption,
    bool tempPay,
    String type,
    String category,
    String currency) async {
  await db.collection('financeList').add(FinanceItem(
          participants: participants,
          dateMonth: dateMonth,
          dateDay: dateDay,
          dateYear: dateYear,
          desc: desc,
          amount: amount,
          splitOption: splitOption,
          isTempPay: tempPay,
          type: type,
          category: category,
          currency: currency)
      .toJson());
}

// get financeList
List<String> financeListId = [];
Future getFinanceListId() async {
  financeListId.clear();
  await db.collection('financeList').get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        financeListId.add(docSnapshot.reference.id);
      }
    },
    onError: (e) => print("Error completing : $e"),
  );
}

// get financeItem (checkout list_page, need reformat)


// update item in db

// delete item from db

