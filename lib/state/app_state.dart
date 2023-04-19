import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_provider.dart';

final appStateProvider = StateNotifierProvider<AppState, dynamic>((ref) {
  /// コンストラクターをつかって依存性を注入したほうがいい。
  /// そのほうが、何に依存しているか分かりやすい。
  /// ようは、 ref を渡すと、refが何を参照するのかがコードを読むまで分からず、
  /// 一覧も不明。
  return AppState(ref);
});

/// そもそもこのStateNotifierの存在意義が不明
/// stateは使われるの？
/// dynamic だけど。
/// ただ関数が集まっているだけのクラスは StateNotifier である必要がない。

/// こんな感じでいいのでは？
/// ```dart
/// final memoRepositoryProvider = Provider((ref) => MemoRepository(ref.watch(firebaseProvider)));
/// class MemoRepository {
///   MemoRepository(this.firestore);
///   final FirebaseFirestore firestore;
///
///   /// これ以降にmemosに関する関数群
/// }
/// ```

class AppState extends StateNotifier<List> {
  final Ref _ref;

  AppState(this._ref) : super([]);

  /// createMemo とかの関数名の方がいいかも
  /// addMemo とか
  //タスク追加
  Future<void> textAdd(String text) async {
    final ref = await _ref
        .read(firebaseProvider)
        .collection('users')
        .doc(Uid)
        .collection('memos')
        .add({
      'text': text,
      'createdAt': Timestamp.fromDate(
        DateTime.now(),
      ), // FieldValue.serverTimestamp() のほうがいいかも。サーバーの時間は不正できない。
      'isDone': false
    });
  }

  /// 関数の上でコメントを書くなら 必ず /// これを使おう
  /// 詳しくは下記URLを熟読してほしい
  /// https://dart.dev/guides/language/effective-dart/documentation

  /// dynamic を引数に絶対しないでほしい
  /// 意味がわからない。
  /// QueryDocumentSnapshot が正解みたい
  /// それすらいるか？ id だけあったらええんかもよ。
  /// そもそも。
  /// document.reference.update だけでいい。
  //タスク削除
  Future<void> textUpdate(dynamic document, String text) async {
    await _ref
        .read(firebaseProvider)
        .collection('users')
        .doc(Uid)
        .collection('memos')
        .doc(document.id)
        .update({'text': text});
  }

  //タスク編集
  Future<void> deleteMemo(dynamic document) async {
    await _ref
        .read(firebaseProvider)
        .collection('users')
        .doc(Uid)
        .collection('memos')
        .doc(document.id)
        .delete();
  }

  //ユーザー削除
  void deleteUser() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    final msg =
        await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('memos')
        .doc(uid)
        .delete();
    // ユーザーを削除
    await user?.delete();
    await FirebaseAuth.instance.signOut();
  }

  //タスクが完了しているか
  Future<void> isDoneTasks(dynamic document, bool value) async {
    await _ref
        .read(firebaseProvider)
        .collection('users')
        .doc(Uid)
        .collection('memos')
        .doc(document.id)
        .update({'isDone': value});
  }

  //スイッチの切り替え
  Future<void> upDateSwitch(bool value) async {
    await _ref
        .read(firebaseProvider)
        .collection('users')
        .doc(Uid)
        .update({'shouldNotification': value});
  }
}
