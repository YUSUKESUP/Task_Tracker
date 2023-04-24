import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_provider.dart';

final memoRepositoryProvider = Provider((ref) => MemoRepository(ref.watch(firebaseFirestoreProvider), ref));

 class MemoRepository {

   final FirebaseFirestore firestore;
   final Ref _ref;

   MemoRepository(this.firestore, this._ref);

 ///タスク追加
  Future<void> addMemo(String text) async {
    final uid = _ref.watch(uidProvider);
      await _ref
        .read(firebaseFirestoreProvider)
        .collection('users')
        .doc(uid)
        .collection('memos')
        .add({
      'text': text,
      'createdAt': Timestamp.fromDate(DateTime.now()),
      'isDone': false
    });
  }
   ///タスク編集　
   Future<void> updateMemo(QueryDocumentSnapshot document, String text) async {
     await document.reference.update({'text': text});
   }

   ///タスク削除
  Future<void> deleteMemo(QueryDocumentSnapshot document) async {
    await document.reference.delete();
  }

   ///タスクが完了しているか
   Future<void> isDoneTasks(QueryDocumentSnapshot document, bool value) async {
     await document.reference.update({'isDone': value});
   }


   ///ユーザー削除
  void deleteUser() async {
    final uid = _ref.watch(uidProvider);
    final user = FirebaseAuth.instance.currentUser;
    final msg =
        await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('memos')
        .doc(uid)
        .delete();
    await user?.delete();
    await FirebaseAuth.instance.signOut();
  }

  ///スイッチの切り替え
  Future<void> upDateSwitch(bool value) async {
    final uid = _ref.watch(uidProvider);
    await _ref
        .read(firebaseFirestoreProvider)
        .collection('users')
        .doc(uid)
        .update({'shouldNotification': value});
  }
 }
