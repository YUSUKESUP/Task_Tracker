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

    test('deleteMemoメソッドのテスト', () async {
      // 新規メモを追加
      final memoRef = await container.read(firebaseFirestoreProvider)
          .collection('users')
          .doc('test_user_id')
          .collection('memos')
          .doc();
      await memoRef.set({'text': 'Test memo', 'isDone': false});

      // メモを削除
      final snapshots =  await container.read(firebaseFirestoreProvider)
          .collection('users')
          .doc('test_user_id')
          .collection('memos')
          .get();
      final document = snapshots.docs.first;
      await memoRepository.deleteMemo(document);

      // メモが削除されたことを確認
      final snapshot = await memoRef.get();
      expect(snapshot.exists, isFalse);
    });

  });
}
