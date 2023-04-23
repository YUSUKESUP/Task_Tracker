import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/model/memo_medol.dart';

final postsReference = FirebaseFirestore.instance.collection('posts').withConverter<Memo>(
  fromFirestore: ((snapshot, _) {
    return Memo.fromFirestore(snapshot);
  }),
  toFirestore: ((value, _) {
    return value.toMap();
  }),
);
