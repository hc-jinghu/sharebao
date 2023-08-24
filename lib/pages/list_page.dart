import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharebao/const.dart';
import 'package:sharebao/components/finance_item_tile.dart';
import 'package:sharebao/data/finance_data.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // Month picker
  DateTime date = DateTime.now();
  void _showMonthDialog(Widget child) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 200,
        padding: const EdgeInsets.only(top: 6),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // app bar. Month button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black38),
                  ),
                ),
                child: CupertinoButton(
                  onPressed: () => _showMonthDialog(
                    CupertinoDatePicker(
                      initialDateTime: date,
                      maximumYear: DateTime.now().year,
                      mode: CupertinoDatePickerMode.monthYear,
                      onDateTimeChanged: (DateTime newDate) {
                        setState(() => date = newDate);
                      },
                    ),
                  ),
                  child: Text(
                    monthEng(date.month),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          // TODO: add Filter and Settle

          // The list of financeItems
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
              ),

              // Build monthly finance list tiles
              child: FutureBuilder(
                future: getfinanceItemWithMonth(date.year, date.month),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: financeItemWithMonth.length,
                    itemBuilder: (context, index) {
                      return FinanceListTile(item: monthlyFinanceItem);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
