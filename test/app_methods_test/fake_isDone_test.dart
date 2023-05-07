import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_crud/application/provider/app_methods.dart';
import 'package:firebase_crud/application/provider/firebase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('メモリポジトリー', () {
    late MemoRepository memoRepository;
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
          uidProvider.overrideWithValue('test_user_id'),
        ],
      );
      memoRepository = container.read(memoRepositoryProvider);
    });

    test('isDoneTasksメソッドのテスト', () async {
      // メモを追加する
      final memoRef = await container.read(firebaseFirestoreProvider)
          .collection('users')
          .doc('test_user_id')
          .collection('memos')
          .add({'text': 'Test memo', 'isDone': false});

      /// メモを更新する
      final snapshots = await container.read(firebaseFirestoreProvider)
          .collection('users')
          .doc('test_user_id')
          .collection('memos')
          .get();
      final document = snapshots.docs.first;
      await memoRepository.isDoneTasks(document, true);

      /// メモが更新されたことを確認する
      final snapshot = await memoRef.get();
      expect(snapshot.data()?['isDone'], equals(true));
    });
  });
}
