import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sharebao/components/finance_item_tile.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // document id
  List<String> financeListId = [];

  // get financeList document id
  Future getFinanceListId() async {
    financeListId.clear();
    await FirebaseFirestore.instance.collection('financeList').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              financeListId.add(document.reference.id);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // TODO: add dateMonth variable (button to change displayed month)
          // It needs to behave like an AppBar, stays on top while scrolling
          Text(
            'Month',
            style: TextStyle(fontSize: 20),
          ),

          const SizedBox(
            height: 10,
          ),
          // TODO: add Filter and Settle

          // The list of financeItems
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 5,
                left: 5,
                right: 5,
              ),

              // Build finance list tiles
              child: FutureBuilder(
                future: getFinanceListId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: financeListId.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('financeList')
                            .doc(financeListId[index])
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> financeItem =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return FinanceListTile(item: financeItem);
                          }
                          return Text('...');
                        },
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
