import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// これも名前変
/// firestore の provider だと思う。
final firebaseProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final textProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

/// これだと一度きりで、uidに変更があった場合にバグの原因になる
/// ログアウト後に再ログインなど。
/// 今の仕様にはないが、今後追加される可能性は十分にありそう。
final snapshot = FirebaseAuth.instance.currentUser;
String? Uid = snapshot?.uid;

final userProvider = StreamProvider(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);

final uidProvider = Provider((ref) {
  final user = ref.watch(userProvider).valueOrNull;
  return user?.uid;
});

/// Memoクラスは作った方が良い
/// Flutterの教科書を参考にしてください。
/// withConverterを使って変換するところまでやろう。

final firebaseTasksProvider = StreamProvider.autoDispose((ref) {
  final uid = ref.watch(uidProvider);
  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('memos')
      .orderBy('createdAt')
      .snapshots();
});

final firebaseNotificationsProvider = StreamProvider.autoDispose((ref) {
  final uid = ref.watch(uidProvider);
  return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
});
