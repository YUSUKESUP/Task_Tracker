import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_crud/components/month_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../datetime/date_time.dart';
import '../utils/app_state.dart';
import '../utils/firebase_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<QuerySnapshot> firebaseMemos =
        ref.watch(firebaseMemosProvider);

    final controllerProvider = ref.watch(textProvider);

    return Scaffold(
      backgroundColor: Color(0xffFDF3E6),
      appBar: AppBar(
          backgroundColor: Color(0xffFDF3E6),
          elevation: 0, actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ),
          ),
        )
      ]),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: MonthlySummary(
                datasets: {DateTime(2023, 3, 26): 10},
                startDate: todaysDateFormatted()),
          ),
          firebaseMemos.when(
            data: (QuerySnapshot query) {
              return Expanded(
                child: ListView(
                  children: query.docs.map((document) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (){
                              ref.read(appStateProvider
                                  .notifier)
                                  .textUpdate(
                              document,
                              controllerProvider
                              .text);
                            },
                            backgroundColor: Colors.grey.shade800,
                            icon: Icons.settings,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          SlidableAction(
                            onPressed: (){
                              ref.read(appStateProvider.notifier)
                                  .deleteMemo(document);
                            },
                            backgroundColor: Colors.red.shade400,
                            icon: Icons.delete,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ],
                      ),
                      child: Card(
                        child: Column(
                          children:  [
                            ListTile(
                              leading: Icon(Icons.add),
                              title: Text(document['text']),
                            ),
                          ],
                        ),
                        color: Colors.white,
                        margin: const EdgeInsets.all(10),
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),

                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
            loading: () {
              return const Text('Loading');
            },

            error: (e, stackTrace) {
              return Text('error: $e');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            context: context,
            barrierColor: Colors.black.withOpacity(0.2),
            builder: (BuildContext ctx) {
              return Container(
                height: MediaQuery.of(context).size.height * 50,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controllerProvider,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: '文字を入力してください',
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () async {
                          ref
                              .read(appStateProvider.notifier)
                              .textAdd(controllerProvider.text);
                          Navigator.pop(context);
                        },
                        child: Text('新規登録')),
                  ],
                ),
              );
            },
          );
        },
        shape: const CircleBorder(
            side: BorderSide(color: Colors.black, width: 2.0)),
        child: const Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.white,
      ),
    );
  }
}
