import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_crud/application/provider/app_methods.dart';
import 'package:firebase_crud/application/provider/firebase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('タスクリポジトリー', () {
    late final ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
          uidProvider.overrideWithValue('test_user_id'),
        ],
      );
    });

    test('addTaskメソッドのテスト', () async {
      await container.read(tasksRepositoryProvider).addTask('Test task');

      /// Firestoreからタスクを取得
      final snapshots = await container
          .read(firebaseFirestoreProvider)
          .collection('users')
          .doc('test_user_id')
          .collection('tasks')
          .get();

      /// 追加されたタスクが期待通りか確認
      expect(snapshots.docs.length, equals(1));
      expect(snapshots.docs.first.data()['text'], equals('Test task'));
      expect(snapshots.docs.first.data()['isDone'], equals(false));
    });
  });
}
