import 'package:sharebao/const.dart';

// create user

// get user

// get user document ids
List<String> userId = [];
Future getUserId() async {
  userId.clear();
  await db.collection('users').get().then(
        (snapshot) => snapshot.docs.forEach(
          (document) {
            userId.add(document.reference.id);
          },
        ),
      );
}

// update user

// delete user



// need to read from database 
  // get total temp payment
  // double getTotalTemp() {
  //   var values = tempPayment.values;
  //   return values.fold(0.0, (sum, value) => sum + value);
  // }

  // // get total split payment
  // double getTotalSplit() {
  //   var values = splitPayment.values;
  //   return values.fold(0.0, (sum, value) => sum + value);
  // }