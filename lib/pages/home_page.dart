import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_crud/components/month_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green[300],
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MonthlySummary(
              datasets: {DateTime(2023, 3, 26): 10},
              startDate: todaysDateFormatted()),
          firebaseMemos.when(
            data: (QuerySnapshot query) {
              return Expanded(
                child: ListView(
                  children: query.docs.map((document) {
                    return Card(
                      child: ListTile(
                        // postで送った内容を表示する
                        title: Text(document['text']),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: 400,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const Text('Modal BottomSheet'),
                                              TextFormField(
                                                controller: controllerProvider,
                                                //providerに定義したコントローラーを使う
                                                decoration:
                                                    const InputDecoration(
                                                  border:
                                                      UnderlineInputBorder(),
                                                  labelText: '文字を入力してください',
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    ref
                                                        .read(appStateProvider
                                                            .notifier)
                                                        .textUpdate(
                                                            document,
                                                            controllerProvider
                                                                .text);
                                                  },
                                                  child: Text('編集')),
                                              SizedBox(height: 20),
                                              ElevatedButton(
                                                child: const Text('閉じる'),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () async {
                                  ref
                                      .read(appStateProvider.notifier)
                                      .deleteMemo(document);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
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

            // エラー（例外発生）時
            error: (e, stackTrace) {
              return Text('error: $e');
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
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
          // showDialog(context: context, builder: (context){
          //   return MyAlertBox();
          // });
        },
        tooltip: 'Add Note',
        shape: const CircleBorder(
            side: BorderSide(color: Colors.black, width: 2.0)),
        child: const Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.white,
      ),
    );
  }
}
