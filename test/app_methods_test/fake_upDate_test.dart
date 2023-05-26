import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_crud/application/provider/app_methods.dart';
import 'package:firebase_crud/application/provider/firebase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('タスクリポジトリー', () {
    late TasksRepository tasksRepository;
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
          uidProvider.overrideWithValue('test_user_id'),
        ],
      );
      tasksRepository = container.read(tasksRepositoryProvider);
    });

    test('updateTaskメソッドのテスト', () async {
      /// タスクを追加
      final taskRef = await container.read(firebaseFirestoreProvider)
          .collection('users')
          .doc('test_user_id')
          .collection('tasks')
          .add({'text': 'Test task', 'isDone': false});

      /// タスクを更新
      final snapshots = await container.read(firebaseFirestoreProvider)
          .collection('users')
          .doc('test_user_id')
          .collection('tasks')
          .get();
      final document = snapshots.docs.first;
      await tasksRepository.updateTask(document, 'Updated task');

      /// メモが更新されたことを確認
      final snapshot = await taskRef.get();
      expect(snapshot.data()?['text'], equals('Updated task'));
    });
  });
}
