import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_crud/application/provider/app_methods.dart';
import 'package:firebase_crud/application/provider/firebase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('メモリポジトリー', () {
    late MemoRepository memoRepository;
    late ProviderContainer container;

    setUp(() async {

      await container.read(firebaseFirestoreProvider)
          .collection('users')
          .doc('test_user_id')
          .set({'shouldNotification': false});
       container = ProviderContainer(
        overrides: [
          firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
          uidProvider.overrideWithValue('test_user_id'),
        ],
      );
      memoRepository = container.read(memoRepositoryProvider);
    });


    test('updateSwitchメソッドのテスト', () async {
      // switchの値を更新
      await memoRepository.upDateSwitch(true);

      // switchの値が更新されたことを確認
      final snapshot =  await container.read(firebaseFirestoreProvider)
          .collection('users')
          .doc('test_user_id')
          .get();
      expect(snapshot.data()?['shouldNotification'], equals(true));
    });
  });
}
