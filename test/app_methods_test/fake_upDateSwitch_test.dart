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

    test('updateSwitch should update switch value in Firestore', () async {
      // update switch value
      await memoRepository.upDateSwitch(true);

      // verify that the switch value was updated
      final snapshot = await firestore
          .collection('users')
          .doc('test_user_id')
          .get();
      expect(snapshot.data()?['shouldNotification'], equals(true));
    });
  });
}
