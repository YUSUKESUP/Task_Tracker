import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final firebaseProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);


final textProvider = StateProvider.autoDispose((ref) {

  return TextEditingController(text: '');
});


final firebaseMemosProvider = StreamProvider.autoDispose((_) {
  return FirebaseFirestore.instance.collection('memos').snapshots();
});

