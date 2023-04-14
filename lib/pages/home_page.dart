import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/components/month_summary.heatmap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../data/heatmap_database.dart';
import '../state/app_state.dart';
import '../state/firebase_provider.dart';
import '../widget/mordal.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseTasks = ref.watch(firebaseTasksProvider);
    final controllerProvider = ref.watch(textProvider);

    //firebaseTasksの値ををfirebaseTasksSnapshotListsへ
    final firebaseTasksSnapshot = firebaseTasks.valueOrNull;
    final List<Map<String, dynamic>> firebaseTasksSnapshotLists = [];
    firebaseTasksSnapshotLists.addAll(
        firebaseTasksSnapshot?.docs.map((doc) => doc.data()).toList() ?? []);

    //fetchHeatMapDateSetを呼び出し引数を渡す
    TaskDatabase taskDatabase = TaskDatabase();
    Map<DateTime, int>? heatmapDates =
        taskDatabase.fetchHeatMapDateSet(firebaseTasksSnapshotLists);

    int count = 0; // keyのデフォルト値を設定

    if (heatmapDates != null && heatmapDates.isNotEmpty) {
      count = heatmapDates.values
          .elementAt(0); // heatmapDatesがnullでなく、かつkeysが空でない場合にkeyを取得
    }

    return Scaffold(
      backgroundColor: const Color(0xffFDF3E6),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //ヒートマップ
            MonthlySummaryHeatMap(
              heatmapDatasets: heatmapDates,
              value: count,
            ),

            // Padding(
            //   padding: const EdgeInsets.only(top: 72.0),
            //   child: SvgPicture.asset(
            //     'assets/undraw_add_files_re_v09g.svg',
            //     semanticsLabel: 'shopping',
            //     width: 200,
            //     height: 200,
            //   ),
            // ),

            firebaseTasks.when(
              data: (QuerySnapshot query) {
                return Expanded(
                  child: ListView(
                    children: query.docs.map((document) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25)),
                                  ),
                                  context: context,
                                  barrierColor: Colors.black.withOpacity(0.2),
                                  builder: (BuildContext ctx) {
                                    return MordalPage(
                                      controller: controllerProvider,
                                      onPress: () {
                                        ref
                                            .read(appStateProvider.notifier)
                                            .textUpdate(document,
                                                controllerProvider.text);
                                        controllerProvider.clear();
                                        Navigator.pop(ctx);
                                      },
                                      buttonName: '編集',
                                    );
                                  },
                                );
                              },
                              backgroundColor: Colors.grey.shade800,
                              icon: Icons.settings,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                ref
                                    .read(appStateProvider.notifier)
                                    .deleteMemo(document);
                              },
                              backgroundColor: Colors.red.shade400,
                              icon: Icons.delete,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 75,
                            child: Center(
                              child: ListTile(
                                leading: Checkbox(
                                  activeColor: Colors.black,
                                  value: document['isDone'],
                                  onChanged: (bool? value) {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(Uid)
                                        .collection('memos')
                                        .doc(document.id)
                                        .update({'isDone': value});
                                  },
                                ),
                                title: Text(
                                  document['text'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      decoration: document['isDone'] ?? false
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                                ),
                              ),
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
              error: (e, stackTrace) {
                return Text('error: $e');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            context: context,
            barrierColor: Colors.black.withOpacity(0.2),
            builder: (BuildContext ctx) {
              return MordalPage(
                controller: controllerProvider,
                onPress: () {
                  ref
                      .read(appStateProvider.notifier)
                      .textAdd(controllerProvider.text);
                  controllerProvider.clear();
                  Navigator.pop(context);
                },
                buttonName: 'タスクを追加',
              );
            },
          );
        },
        shape: const CircleBorder(
            side: BorderSide(color: Colors.black, width: 2.0)),
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
