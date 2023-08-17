import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharebao/components/finance_item_tile.dart';
import 'package:sharebao/models/finance_item.dart';
import 'package:sharebao/models/finance_list.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceList>(
      builder: (context, value, child) => SafeArea(
        child: Column(
          children: [
            // TODO: add Month (button to change displayed month)
            // It needs to behave like an AppBar, stays on top while scrolling
            Text(
              'Finance List',
              style: TextStyle(fontSize: 20),
            ),

            const SizedBox(
              height: 10,
            ),
            // TODO: add Filter and Settle

            // list of finance items
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 5,
                  left: 5,
                  right: 5,
                ),
                child: ListView.builder(
                    itemCount: value.financeList.length,
                    itemBuilder: (context, index) {
                      // get indivisual list item
                      FinanceItem eachItem = value.financeList[index];
                      // return the tile for this item
                      return FinanceListTile(item: eachItem);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
