import 'package:firebase_crud/data/heatmap_database.dart';
import 'package:firebase_crud/model/memo.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  test('fetchHeatMapDateSet returns expected map', () {
    // テスト用のデータ
    final List<Memo> tasks = [
      Memo(text: 'Task 1', createdAt: DateTime(2022, 4, 1), isDone: true),
      Memo(text: 'Task 2', createdAt: DateTime(2022, 4, 1), isDone: true),
      Memo(text: 'Task 3', createdAt: DateTime(2022, 4, 2), isDone: true),
      Memo(text: 'Task 4', createdAt: DateTime(2022, 4, 3), isDone: true),
      Memo(text: 'Task 5', createdAt: DateTime(2022, 4, 3), isDone: true),
      Memo(text: 'Task 6', createdAt: DateTime(2022, 4, 3), isDone: true),
      Memo(text: 'Task 7', createdAt: DateTime(2022, 4, 5), isDone: true),
      Memo(text: 'Task 8', createdAt: DateTime(2022, 4, 7), isDone: true),
    ];

    // テスト用の期待する結果
    final expectedMap = {
      DateTime(2022, 4, 1): 2,
      DateTime(2022, 4, 2): 1,
      DateTime(2022, 4, 3): 3,
      DateTime(2022, 4, 5): 1,
      DateTime(2022, 4, 7): 1,
    };

    // fetchHeatMapDateSetメソッドの実行
    final resultMap = fetchHeatMapDateSet(tasks);

    // 期待する結果と一致するか確認
    expect(resultMap.length, expectedMap.length);
    expectedMap.forEach((key, value) {
      expect(resultMap[key], value);
    });
  });
}
