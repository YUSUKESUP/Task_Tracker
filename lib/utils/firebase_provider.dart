import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final firebaseProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);


final textProvider = StateProvider.autoDispose((ref) {

  return TextEditingController(text: '');
});

final userId = FirebaseAuth.instance;


final firebaseTasksProvider = StreamProvider.autoDispose((_) {
  return FirebaseFirestore.instance.collection('users').doc('uid').collection('memos').snapshots();
});


final firebaseNotificationsProvider = StreamProvider.autoDispose((_) {
return FirebaseFirestore.instance.collection('users').doc('uid').snapshots();
}

);

