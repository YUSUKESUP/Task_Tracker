import 'package:firebase_crud/domain/model/task.dart';
import 'package:flutter/material.dart';


Map<DateTime, int> fetchHeatMapDateSet(List<Task> tasks) {
  final map = <DateTime, int>{};

  ///スタートの日付を設定
  final startDate = DateTime(DateTime.now().year, 4);

  ///日数
  const int maxDaysInMonth = 365;

  ///タスクが完了した日を１日づつ確認
  for (var i = 0; i < maxDaysInMonth; i++) {
    final date = startDate.add(Duration(days: i));

    final taskCounts = tasks
        .where((element) =>
    DateUtils.isSameDay(element.createdAt, date) == true &&
        element.isDone == true)
        .length;

    if (taskCounts != 0) {
      map[date] = taskCounts;
    }
  }
  return map;
}


// import 'package:flutter/material.dart';
// import '../model/memo.dart';
//
// Map<DateTime, int> fetchHeatMapDateSet(List<Memo> tasks) {
//   final map = <DateTime, int>{};
//
//   ///スタートの日付を設定
//   final startDate = DateTime(DateTime.now().year, 4);
//
//   ///日数
//   theme int maxDaysInMonth = 365;
//
//   ///タスクが完了した日を１日づつ確認
//   for (var i = 0; i < maxDaysInMonth; i++) {
//     final date = startDate.add(Duration(days: i));
//
//     final taskCounts = tasks
//         .where((element) =>
//     DateUtils.isSameDay(element.createdAt, date) == true &&
//         element.isDone == true)
//         .length;
//
//     if (taskCounts != 0) {
//       map[date] = taskCounts;
//     }
//   }
//   return map;
// }
