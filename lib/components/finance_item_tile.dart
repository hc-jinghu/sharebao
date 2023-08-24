import 'package:flutter/material.dart';
import 'package:sharebao/pages/finance_item_page.dart';

class FinanceListTile extends StatelessWidget {
  final Map<String, dynamic> item;
  const FinanceListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FinanceItemPage(item: item),
          ),
        );
      },
      child: ListTile(
        shape: const Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 209, 209, 209),
            width: 0.8,
          ),
        ),
        // tileColor: Colors.pink,
        title: Text(item['desc']),
        subtitle: Text('${item['dateMonth']}/${item['dateDay']}'),
        leading: Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset('lib/icons/bill.png'),
            ),
            Wrap(
              direction: Axis.vertical,
              children: [
                Text(
                  item['category'],
                  style: TextStyle(fontSize: 16),
                ),
                Text(item['split'].toString())
              ],
            ),
          ],
        ),
        trailing: Text(
          '\$${item['amount']}',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
