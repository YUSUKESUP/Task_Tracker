import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/utils/app_state.dart';
import 'package:crud_app/utils/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReadPage extends ConsumerWidget {
  const ReadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<QuerySnapshot> firebaseMemos =
    ref.watch(firebaseMemosProvider);
    // textProviderを呼び出す定数を定義
    final controllerProvider = ref.watch(textProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Read'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text('FireStoreのデータを全件取得'),
            SizedBox(height: 20),
            firebaseMemos.when(
              // データがあった（データはqueryの中にある）
              data: (QuerySnapshot query) {
                // post内のドキュメントをリストで表示する
                return Expanded(
                  child: ListView(
                    // post内のドキュメント１件ずつをCard枠を付けたListTileのListとしてListViewのchildrenとする
                    children: query.docs.map((document) {
                      return Card(
                        child: ListTile(
                          // postで送った内容を表示する
                          title: Text(document['text']),
                          // CardWidgetにボタンを２個配置できるように、
                          // SizedBoxとRowでWrapする
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
                                                  controller:
                                                  controllerProvider, //providerに定義したコントローラーを使う
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

              // データの読み込み中（FireStoreではあまり発生しない）
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
      ),
    );
  }
}