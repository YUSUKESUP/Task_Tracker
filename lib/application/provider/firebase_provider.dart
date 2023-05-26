import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/model/task.dart';

///Firebaseの情報取得
final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);


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

///tasksサブコレクションの取得
final firebaseTasksProvider = StreamProvider<QuerySnapshot<Task>>((ref) {
  final uid = ref.watch(uidProvider);
  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('tasks')
      .orderBy('createdAt')
      .withConverter<Task>(
      fromFirestore: (snapshot, _) => Task.fromFirestore(snapshot),
      toFirestore: (task, _) => task.toDocument())
      .snapshots();
});

///TextEditingControllerを使うため
final textEditingController = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});