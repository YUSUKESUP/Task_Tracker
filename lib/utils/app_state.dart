import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_provider.dart';




final appStateProvider = StateNotifierProvider<AppState, dynamic>((ref) {

  return AppState(ref);
});

class AppState extends StateNotifier<dynamic> {

  final Ref _ref;

  AppState(this._ref) : super([]);

  Future<void> textAdd(String text) async {

    final ref = await _ref.read(firebaseProvider).collection('memos')

        .add({'text': text, 'createdAt': Timestamp.fromDate(DateTime.now())});
  }

  Future<void> textUpdate(dynamic document, String text) async {
    await FirebaseFirestore.instance
        .collection('memos')
        .doc(document.id)
        .update({'text': text});
  }


  Future<void> deleteMemo(dynamic document) async {
    await FirebaseFirestore.instance
        .collection('memos')
        .doc(document.id)
        .delete();
  }
}