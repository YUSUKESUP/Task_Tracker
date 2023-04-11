import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_provider.dart';

final appStateProvider = StateNotifierProvider<AppState, dynamic>((ref) {
  return AppState(ref);
});

class AppState extends StateNotifier<dynamic> {
  final Ref _ref;

  AppState(this._ref) : super([]);

  Future<void> textAdd(String text) async {
    final ref = await _ref
        .read(firebaseProvider)
        .collection('users')
        .doc(Uid)
        .collection('memos')
        .add({
      'text': text,
      'createdAt': Timestamp.fromDate(DateTime.now()),
      'isDone': false
    });
  }

  //タスク削除
  Future<void> textUpdate(dynamic document, String text) async {
    await _ref
        .read(firebaseProvider)
        .collection('users')
        .doc(Uid)
        .collection('memos')
        .doc(document.id)
        .update({'text': text});
  }

  //タスク編集
  Future<void> deleteMemo(dynamic document) async {
    await _ref
        .read(firebaseProvider)
        .collection('users')
        .doc(Uid)
        .collection('memos')
        .doc(document.id)
        .delete();
  }

  //ユーザー削除
  void deleteUser() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    final msg =
        await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('memos')
        .doc(uid)
        .delete();
    // ユーザーを削除
    await user?.delete();
    await FirebaseAuth.instance.signOut();
  }
}
