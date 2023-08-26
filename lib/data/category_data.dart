import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharebao/const.dart';

// category data for db

// types
final List<String> types = ["Expense", "Income"];

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
  db.collection('categories').doc('category').get().then(
    (snapshot) {
      categories = snapshot.data() as Map<String, dynamic>;
    },
  );
}

// get income types
List<String> incomeCategories = [];
void getIncomeCategories(Map<String, dynamic> categories) {
  incomeCategories.clear();
  categories.forEach(
    (key, value) {
      if (value == types.last) {
        incomeCategories.add(key);
      }
    },
  );
}

// get expense types
List<String> expenseCategories = [];
void getExpenseCategories(Map<String, dynamic> categories) {
  expenseCategories.clear();
  categories.forEach(
    (key, value) {
      if (value == types.first) {
        expenseCategories.add(key);
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
Future deleteCategory(String name) async {
  await db.collection('categories').doc('category').update({
    name: FieldValue.delete(),
  });
}
