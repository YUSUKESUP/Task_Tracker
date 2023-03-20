import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_provider.dart';

// 外部からStateNotifierを呼び出せるようになるProvider
final appStateProvider = StateNotifierProvider<AppState, dynamic>((ref) {
  // Riverpod2.0はここの引数にrefを書かなければエラーになる!
  return AppState(ref);
});

class AppState extends StateNotifier<dynamic> {
  // Refを使うと他のファイルのProviderを呼び出せる
  final Ref _ref;
  // superは、親クラスのコンストクラスターを呼び出す
  AppState(this._ref) : super([]);
  // FireStoreにデータを追加するメソッド
  Future<void> textAdd(String text) async {
    // _ref.read()と書いて、firebaseProviderを呼び出す
    final ref = await _ref.read(firebaseProvider).collection('memos')
    // createdAtは、FireStoreに作成した時刻をTimestampで保存する
        .add({'text': text, 'createdAt': Timestamp.fromDate(DateTime.now())});
  }

  // FireStoreのデータを編集するメソッド
  Future<void> textUpdate(dynamic document, String text) async {
    await FirebaseFirestore.instance
        .collection('memos')
        .doc(document.id)
        .update({'text': text});
  }

  // FireStoreのデータを削除するメソッド
  Future<void> deleteMemo(dynamic document) async {
    await FirebaseFirestore.instance
        .collection('memos')
        .doc(document.id)
        .delete();
  }
}