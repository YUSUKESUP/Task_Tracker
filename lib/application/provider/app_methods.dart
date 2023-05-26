import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_provider.dart';

final tasksRepositoryProvider = Provider((ref) => TasksRepository(ref.watch(firebaseFirestoreProvider), ref));

 class TasksRepository {

   final FirebaseFirestore firestore;
   final Ref _ref;

   TasksRepository(this.firestore, this._ref);

  ///タスク追加
  Future<void> addTask(String text) async {
    final uid = _ref.watch(uidProvider);
      await _ref
        .read(firebaseFirestoreProvider)
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .add({
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
      'isDone': false
    });
  }

   ///タスク編集　
   Future<void> updateTask(QueryDocumentSnapshot document, String text) async {
     await document.reference.update({'text': text});
   }

   ///タスク削除
  Future<void> deleteTask(QueryDocumentSnapshot document) async {
    await document.reference.delete();
  }

   ///タスクが完了しているか
   Future<void> isDoneTasks(QueryDocumentSnapshot document, bool value) async {
     await document.reference.update({'isDone': value});
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


   ///ユーザー削除
  void deleteUser() async {
    final uid = _ref.watch(uidProvider);
    final user = FirebaseAuth.instance.currentUser;
    final msg =
        await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(uid)
        .delete();
    await user?.delete();
    await FirebaseAuth.instance.signOut();
  }

 }
