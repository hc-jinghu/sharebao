import 'package:flutter/material.dart';
import 'finance_item.dart';

class FinanceList extends ChangeNotifier {
  // finance item to show
  // TODO: use Firebase for backend later
  // example data
  final List<FinanceItem> _list = [
    FinanceItem(
        dateMonth: '8',
        dateDay: '11',
        desc: 'steak dinner',
        amount: 20,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
    FinanceItem(
        dateMonth: '8',
        dateDay: '6',
        desc: 'plane ticket',
        amount: 3000,
        type: 'Expense'),
  ];

  // get financeList
  List<FinanceItem> get financeList => _list;

  // add financeItem to financeList
  void addItemToList(FinanceItem item) {
    _list.add(item);
    notifyListeners();
  }

  // remove financeItem to financeList
  void removeItemFromList(FinanceItem item) {
    _list.remove(item);
    notifyListeners();
  }
}
