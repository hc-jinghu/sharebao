import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharebao/const.dart';
import 'package:sharebao/models/finance_item.dart';

CollectionReference ref = db.collection("financeList");

// TODO: category and currency should be a separate collection? in db
// add financeItem to db
/* 
Initialize financeItem id (empty document), set currId to newId after
  user split/temp has been updated.
*/
String currId = ref.doc().id;
String generateNewId() {
  return ref.doc().id;
}

Future addItem(
    List<String> participants,
    int dateMonth,
    int dateDay,
    int dateYear,
    String desc,
    double amount,
    String splitOption,
    String type,
    String? category,
    String? goal,
    String currency) async {
  await ref.doc(currId).set(FinanceItem(
          participants: participants,
          dateMonth: dateMonth,
          dateDay: dateDay,
          dateYear: dateYear,
          desc: desc,
          amount: amount,
          splitOption: splitOption,
          type: type,
          category: category,
          goal: goal,
          currency: currency)
      .toJson());
  generateNewId();
}

// get data from financeList
List<String> financeListId = [];
Future getFinanceListId() async {
  financeListId.clear();
  await ref.get().then(
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
  await ref
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
//     String? type,
//     String? category,
//     String? currency) async {
//   await db.collection('categories').doc(id).update(

//   );
// }

// delete item from db
