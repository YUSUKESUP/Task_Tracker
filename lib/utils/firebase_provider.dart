import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Firebaseを使うためのProvider
final firebaseProvider =
Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

// TextEditingControllerを使うためのProvider
final textProvider = StateProvider.autoDispose((ref) {
  // riverpodで使うには、('')が必要
  return TextEditingController(text: '');
});

// FireStoreの'memos'コレクションのすべてのドキュメントを取得するプロバイダー。初回に全件分、あとは変更があるたびStreamに通知される。
final firebaseMemosProvider = StreamProvider.autoDispose((_) {
  return FirebaseFirestore.instance.collection('memos').snapshots();
});