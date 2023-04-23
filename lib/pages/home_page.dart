import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/components/month_summary_heatmap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../components/month_summary_calender.dart';
import '../data/heatmap_database.dart';
import '../provider/app_methods.dart';
import '../provider/firebase_provider.dart';
import '../widget/modal.dart';

enum MonthlySummaryMode {
  heatMap,
  calender,
}

class HomePage extends ConsumerWidget {

  final MonthlySummaryMode monthlySummaryMode;

  const HomePage({
    Key? key,
    required this.monthlySummaryMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final firebaseMemos = ref.watch(firebaseMemosProvider);
    final controllerProvider = ref.watch(textEditingController);

    //firebaseMemosの値をfirebaseTasksSnapshotListsへ
    final firebaseTasksSnapshot = firebaseMemos.valueOrNull;
    final List<Map<String, dynamic>> firebaseTasksSnapshotLists = [];
    firebaseTasksSnapshotLists.addAll(
        firebaseTasksSnapshot?.docs.map((doc) => doc.data()).toList() ?? []);

    //fetchHeatMapDateSetを呼び出し引数を渡す
    Map<DateTime, int>? heatmapDates = fetchHeatMapDateSet(firebaseTasksSnapshotLists);

    int count = 0; // keyのデフォルト値を設定

    if (heatmapDates != null && heatmapDates.isNotEmpty) {
      count = heatmapDates.values
          .elementAt(0); // heatmapDatesがnullでなく、かつkeysが空でない場合にkeyを取得
    }


    final appMethod = memoRepositoryProvider;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ///ヒートマップ
            if (monthlySummaryMode == MonthlySummaryMode.heatMap)
              MonthlySummaryHeatMap(
                heatmapDatasets: heatmapDates,
                value: count,
              )
            else
              MonthlySummaryCalemder(
                heatmapDatasets: heatmapDates,
                value: count,
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
                                            .read(appMethod)
                                            .updateMemo(document,
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
                                    .read(appMethod)
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
                                    ref
                                        .read(appMethod)
                                        .isDoneTasks(document,value ?? false);
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
    );
  }
}
