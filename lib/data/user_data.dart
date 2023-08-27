import 'package:sharebao/const.dart';
import 'package:sharebao/models/user.dart';

// create user
Future createUser(String name) async {
  await db.collection('users').add(
        User(name: name).toJson(),
      );
}

// get users
/*
@input: 
@Output: 
- Map<documentID, docSnapshot> users
- List<documentId> userIds
 */
Map<String, dynamic> users = {};
List<String> userIds = [];
Future getUsers() async {
  userIds.clear();
  await db.collection('users').get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        users.addAll({docSnapshot.reference.id: docSnapshot});
      }
      for (var key in users.keys) {
        userIds.add(key);
      }
    },
  );
}

String getUserName(String userId) {
  return users[userId]["name"];
}

// get total temp payment of user
/*
Store tempPayment as a Map<String recordId, double amount> 
then 
var values = tempPayment.values
values.fold(0.0, (sum, value) => sum + value)
 */
Map<String, dynamic> tempPayment = {};
Future getTempPayments(String userId) async {
  await db.collection('users').doc(userId).get().then(
    (snapshot) {
      tempPayment = snapshot.data()!["tempPayment"];
    },
  );
}

double getTotalTemp() {
  var values = tempPayment.values;
  return values.fold(0.0, (sum, value) => sum + value);
}

// get total split payment of user
Map<String, dynamic> splitPayment = {};
Future getSplitPayments(String userId) async {
  await db.collection('users').doc(userId).get().then(
    (snapshot) {
      splitPayment = snapshot.data()!["splitPayment"];
    },
  );
}

double getTotalSplit() {
  var values = splitPayment.values;
  return values.fold(0.0, (sum, value) => sum + value);
}

// update user name
Future updateUserName(String userId, String newName) async {
  await db.collection('users').doc(userId).update({"name": newName});
}

// update temp payment of user
Future updateTempPayment(
    String userId, String recordId, String newAmount) async {
  await db.collection('users').doc(userId).update(
    {"tempPayment.$recordId": newAmount},
  );
}

// update split payment of user
Future splitTempPayment(
    String userId, String recordId, String newAmount) async {
  await db.collection('users').doc(userId).update(
    {"splitPayment.$recordId": newAmount},
  );
}


// delete user


