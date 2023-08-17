import 'package:flutter/material.dart';
import 'package:sharebao/const.dart';

// it's a separate scaffold, no need to show bottom nav bar

class AddItemPage extends StatefulWidget {
  // Type of financeItem, income or expense
  final String type;
  const AddItemPage({super.key, required this.type});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  // Text controllers
  final newItemDescController = TextEditingController();
  final newItemAmountController = TextEditingController();

  // save financeItem
  void save() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Add a Finance Item'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 400,
            width: 400,
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: newItemDescController,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Description'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: newItemAmountController,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Amount'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      focusColor: Colors.purple,
                      onPressed: save,
                      child: Text('save'),
                    ),
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
