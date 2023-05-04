import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_crud/provider/app_methods.dart';
import 'package:firebase_crud/provider/firebase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MemoRepository', () {
    late MemoRepository memoRepository;
    late FakeFirebaseFirestore firestore;

    setUp(() {
      firestore = FakeFirebaseFirestore();
      final container = ProviderContainer(
        overrides: [
          firebaseFirestoreProvider.overrideWithValue(firestore),
          uidProvider.overrideWithValue('test_user_id'),
        ],
      );
      memoRepository = container.read(memoRepositoryProvider);
    });

    test('updateSwitchはFirestore内のswitchの値を更新すること', () async {
      // switchの値を更新
      await memoRepository.upDateSwitch(true);

      // switchの値が更新されたことを確認
      final snapshot = await firestore
          .collection('users')
          .doc('test_user_id')
          .get();
      expect(snapshot.data()?['shouldNotification'], equals(true));
    });
  });
}
