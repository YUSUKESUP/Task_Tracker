import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/model/memo.dart';


final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final textEditingController = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

///ユーザー情報の取得
final userProvider = StreamProvider(
      (ref) => FirebaseAuth.instance.authStateChanges(),
);

///uidの取得
final uidProvider = Provider((ref) {
  final user = ref.watch(userProvider).valueOrNull;
  return user?.uid;
});

///usersコレクションの取得
final firebaseNotificationsProvider = StreamProvider.autoDispose((ref) {
  final uid = ref.watch(uidProvider);
  return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
});

///memosサブコレクションの取得
final firebaseMemosProvider = StreamProvider<QuerySnapshot<Memo>>((ref) {
  final uid = ref.watch(uidProvider);
  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('memos')
      .orderBy('createdAt')
      .withConverter<Memo>(
      fromFirestore: (snapshot, _) => Memo.fromFirestore(snapshot),
      toFirestore: (memo, _) => memo.toDocument())
      .snapshots();
});