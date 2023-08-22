import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharebao/const.dart';

// category data for db

// add category
Future addCategory(String name, String type) async {
  await db.collection('categories').doc('category').set(
    {name: type},
    SetOptions(merge: true),
  );
}

// get categories
Map<String, dynamic> categories = {};
Future getCategories() async {
  await db.collection('categories').doc('category').get().then(
    (snapshot) {
      categories = snapshot.data() as Map<String, dynamic>;
    },
  );
}

// get income types
Map<String, dynamic> incomeCategories = {};
void getIncomeTypes(Map<String, dynamic> categories) {
  categories.forEach(
    (key, value) {
      if (value == "Income") {
        incomeCategories.addAll({key: value});
      }
    },
  );
}

// get expense types
Map<String, dynamic> expenseCategories = {};
void getExpenseTypes(Map<String, dynamic> categories) {
  categories.forEach(
    (key, value) {
      if (value == "Income") {
        incomeCategories.addAll({key: value});
      }
    },
  );
}

// update category
Future updateCategory(String name, String type) async {
  await db.collection('categories').doc('category').update(
    {name: type},
  );
}

// delete category
Future deleteCategory(String name, String type) async {
  await db.collection('categories').doc('category').update({
    name: FieldValue.delete(),
  });
}
