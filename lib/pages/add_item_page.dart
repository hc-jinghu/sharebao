import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sharebao/const.dart';
import 'package:sharebao/models/finance_item.dart';

// Add an income or expense item

class AddItemPage extends StatefulWidget {
  // Type of financeItem, income or expense
  final String type;
  const AddItemPage({super.key, required this.type});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  // Text controllers
  final newItemAmountController = TextEditingController();
  final newItemDescController = TextEditingController();

  // Action button: add
  // TODO: delete example data
  Future add() async {
    addItem(
      8,
      13,
      newItemDescController.text,
      double.parse(newItemAmountController.text),
      1,
      'Temporary Pay',
      'expense',
      'Dining',
      'CAD',
    );
    // TODO: navigate to list page
  }

  // Add financeItem
  // TODO: category and currency should be a separate collection? document? in db
  Future addItem(
      int dateMonth,
      int dateDay,
      String desc,
      double amount,
      double split,
      String tempPay,
      String type,
      String category,
      String currency) async {
    await FirebaseFirestore.instance.collection('financeList').add(FinanceItem(
            dateMonth: dateMonth,
            dateDay: dateDay,
            desc: desc,
            amount: amount,
            split: split,
            tempPay: tempPay,
            type: type,
            category: category,
            currency: currency)
        .toJson());
  }

  @override
  void dispose() {
    newItemDescController.dispose();
    newItemAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('New Record'),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 200,
                    child: Column(
                      children: [
                        // currency + amount
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // TODO: change to CupertinoPicker
                            const Text(
                              'CAD',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: TextField(
                                controller: newItemDescController,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'amount',
                                ),
                              ),
                            ),
                          ],
                        ),
                        // TextField(desc)
                        Row(children: [
                          SizedBox(
                            width: 200,
                            child: TextField(
                              controller: newItemDescController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'desciption',
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  // photo widget (blank sized box for now)
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius: BorderRadius.circular(12)),
                    child: SizedBox.square(
                      dimension: 80,
                      child: MaterialButton(
                        onPressed: () {},
                        child: const Icon(Icons.camera_alt),
                      ),
                    ),
                  )
                ],
              ),
              // date + type + category
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [],
              ),
              // project/budget -> depends on type
              Row(),
              // split
              Row(),
              // Paid by
              Row(),
            ],
          ),
        )

        // child: ClipRRect(
        //   borderRadius: BorderRadius.circular(10),
        //   child: Container(
        //     height: 400,
        //     width: 400,
        //     color: Colors.grey[100],
        //     child: Padding(
        //       padding: const EdgeInsets.all(30),
        //       child: Column(children: [
        //         Wrap(
        //           direction: Axis.vertical,
        //           crossAxisAlignment: WrapCrossAlignment.start,
        //           spacing: 5,
        //           children: [
        //             SizedBox(
        //               width: 250,
        //               child: TextField(
        //                 controller: newItemDescController,
        //                 decoration: InputDecoration(
        //                     border: UnderlineInputBorder(),
        //                     hintText: 'Description'),
        //               ),
        //             ),
        //             SizedBox(
        //               width: 250,
        //               child: TextField(
        //                 controller: newItemAmountController,
        //                 decoration: InputDecoration(
        //                     border: UnderlineInputBorder(), hintText: 'Amount'),
        //               ),
        //             ),
        //             const SizedBox(
        //               height: 10,
        //             ),
        //             SizedBox(
        //               height: 50,
        //               width: 250,
        //               child: MaterialButton(
        //                 focusColor: Colors.purple,
        //                 onPressed: add,
        //                 child: Text('Add'),
        //               ),
        //             )
        //           ],
        //         ),
        //       ]),
        //     ),
        //   ),
        // ),
        );
  }
}
