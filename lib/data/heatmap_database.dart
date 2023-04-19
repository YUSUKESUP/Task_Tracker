import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// class になってる利点がなさそう。
/// testするときはモックをオーバーライドできるが、
/// ロジックとして外部通信をそもそも挟まない、依存している関数やクラスがないので、この関数はそのままテスト可能だし。
class TaskDatabase {
  /// 返り値の型は絶対に書こう
  fetchHeatMapDateSet(List<Map<String, dynamic>> tasks) {
    final map = <DateTime, int>{};

    //スタートの日付を設定
    final startDate = DateTime(DateTime.now().year, 4);

    //日数
    /// dartは定数であってもあんまり大文字はじまりにしない。
    /// とおもう。
    const int MaxDaysInMonth = 365;

    //タスクが完了した日を１日づつ確認
    for (var i = 0; i < MaxDaysInMonth; i++) {
      final date = startDate.add(Duration(days: i));

      final taskCounts = tasks
          .where((element) =>
              DateUtils.isSameDay(
                      (element['createdAt'] as Timestamp).toDate(), date) ==
                  true &&
              element['isDone'] == true)
          .length;

      if (taskCounts != 0) {
        map[date] = taskCounts;
      }
    }
    return map;
  }
}
