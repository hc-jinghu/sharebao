import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharebao/const.dart';
import 'package:sharebao/models/finance_item.dart';

// TODO: category and currency should be a separate collection? in db
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
    String? category,
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

// get data from financeList
List<String> financeListId = [];
Future getFinanceListId() async {
  financeListId.clear();
  await db.collection('financeList').get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        financeListId.add(docSnapshot.reference.id);
      }
    },
    onError: (e) => print("Error getting financeList doc IDs"),
  );
}

/*
// get financeItems with provided dateMonth
@Input: int dateMonth
@Output: DocumentSnapshot. documents with matching dateMonth
 */
List<QueryDocumentSnapshot> financeItemWithMonth = [];
Map<String, dynamic> monthlyFinanceItem = {};
Future getfinanceItemWithMonth(int dateYear, int dateMonth) async {
  financeItemWithMonth.clear();
  await db
      .collection('financeList')
      .where('dateYear', isEqualTo: dateYear)
      .where('dateMonth', isEqualTo: dateMonth)
      .get()
      .then((querySnapshot) {
    for (var docSnapshot in querySnapshot.docs) {
      financeItemWithMonth.add(docSnapshot);
    }
    for (var element in financeItemWithMonth) {
      monthlyFinanceItem = element.data() as Map<String, dynamic>;
    }
    print(financeItemWithMonth);
    print(monthlyFinanceItem);
  }, onError: (e) => print("Error getting finance item with month $dateMonth"));
}

// get single financeItem data
// Output:
Future getFinanceItem() async {}

// update item in db
// Future updateItem(
//     String id,
//     List<String>? participants,
//     int? dateMonth,
//     int? dateDay,
//     int? dateYear,
//     String? desc,
//     double? amount,
//     String? splitOption,
//     bool? tempPay,
//     String? type,
//     String? category,
//     String? currency) async {
//   await db.collection('categories').doc(id).update(

//   );
// }

// delete item from db
