import 'package:flutter/material.dart';
import 'package:sharebao/models/finance_item.dart';

class FinanceListTile extends StatelessWidget {
  final FinanceItem item;
  FinanceListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: Border(
        bottom: BorderSide(
          color: Color.fromARGB(255, 209, 209, 209),
          width: 0.8,
        ),
      ),
      // tileColor: Colors.pink,
      title: Text(item.desc),
      subtitle: Text(item.dateMonth + '/' + item.dateDay),
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
                'Category',
                style: TextStyle(fontSize: 16),
              ),
              Text('Split')
            ],
          ),
        ],
      ),
      trailing: Text(
        '\$' + item.amount.toString(),
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
