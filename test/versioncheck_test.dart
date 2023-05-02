// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_crud/model/memo.dart';
// import 'package:firebase_crud/repository/sample_repository.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
//
// class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
//
// void main() {
//   group('SampleRepository', () {
//     late SampleRepository sampleRepository;
//     late FirebaseFirestore mockFirestore;
//
//     setUp(() {
//       mockFirestore = MockFirebaseFirestore();
//       sampleRepository = SampleRepository(fireStore: mockFirestore);
//     });
//
//     test('getSampleDataList returns list of SampleData', () async {
//       // given
//       final userId = 'testUserId';
//       final memoList = [        Memo(text: 'memo1', createdAt: DateTime.now(), isDone: false),        Memo(text: 'memo2', createdAt: DateTime.now(), isDone: true),      ];
//       final mockQuerySnapshot = MockQuerySnapshot(memoList.map((memo) => MockQueryDocumentSnapshot(memo.toDocument())).toList());
//       when(mockFirestore.collection('users').doc(userId).collection('favoriteData').get()).thenAnswer((_) async => mockQuerySnapshot);
//
//       // when
//       final result = await sampleRepository.getSampleDataList(userId: userId);
//
//       // then
//       expect(result, memoList);
//     });
//
//     test('addData adds Memo to Firestore', () async {
//       // given
//       final userId = 'testUserId';
//       final memo = Memo(text: 'memo1', createdAt: DateTime.now(), isDone: false);
//       final mockDocumentReference = MockDocumentReference();
//       when(mockFirestore.collection('users').doc(userId).collection('favoriteData').doc(memo.id)).thenReturn(mockDocumentReference);
//
//       // when
//       await sampleRepository.addData(userId: userId, sampleData: memo);
//
//       // then
//       verify(mockDocumentReference.set(memo.toJson()));
//     });
//
//     test('updateData updates Memo in Firestore', () async {
//       // given
//       final userId = 'testUserId';
//       final memo = Memo(text: 'memo1', createdAt: DateTime.now(), isDone: false);
//       final mockDocumentReference = MockDocumentReference();
//       when(mockFirestore.collection('users').doc(userId).collection('favoriteData').doc(memo.id)).thenReturn(mockDocumentReference);
//
//       // when
//       await sampleRepository.updateData(userId: userId, sampleData: memo);
//
//       // then
//       verify(mockDocumentReference.update(memo.toJson()));
//     });
//
//     test('deleteData deletes Memo from Firestore', () async {
//       // given
//       final userId = 'testUserId';
//       final memo = Memo(text: 'memo1', createdAt: DateTime.now(), isDone: false);
//       final mockDocumentReference = MockDocumentReference();
//       when(mockFirestore.collection('users').doc(userId).collection('favoriteData').doc(memo.id)).thenReturn(mockDocumentReference);
//
//       // when
//       await sampleRepository.deleteData(userId: userId, sampleData: memo);
//
//       // then
//       verify(mockDocumentReference.delete());
//     });
//   });
// }
