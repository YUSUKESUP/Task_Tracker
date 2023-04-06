import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/utils/firebase_provider.dart';
import 'package:flutter/material.dart';


class TaskDatabase {

  Future<Map<DateTime, int>?> fetchHeatMapDateSet() async {
    final map = <DateTime, int>{};

    //スタートの日付を設定
    final startDate = DateTime.utc(DateTime
        .now()
        .year, 4, 1);
    //終わりの日付を設定
    final endDate = DateTime.utc(DateTime
        .now()
        .year - 1, 3, 31);
    //
    const int MaxDaysInMonth = 365;
    //スタートからエンドまでエンドまで0を入れる
    // map[DateTime.now().copyWith(month: 4,day: 1)] = 0;

    final List<Map<String, dynamic>> tasks = [];


    final subCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(Uid)
        .collection('memos');

    final taskDatas = await subCollectionRef.get();

    tasks.addAll(taskDatas.docs.map((doc) => doc.data()).toList());


    for (var i = 0; i < MaxDaysInMonth; i++) {
      final date = startDate.add(Duration(days: i));

      final taskCounts = tasks.where((element) => DateUtils.isSameDay((element['createdAt'] as Timestamp).toDate(), date) == true && element['isDone'] == true).length;

      map[date] = taskCounts;

    }
    return map;
  }
}
