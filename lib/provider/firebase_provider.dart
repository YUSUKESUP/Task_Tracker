import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final textEditingController = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});


final userProvider = StreamProvider(
      (ref) => FirebaseAuth.instance.authStateChanges(),
);

final uidProvider = Provider((ref) {
  final user = ref.watch(userProvider).valueOrNull;
  return user?.uid;
});

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
