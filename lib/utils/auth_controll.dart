import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// AuthControllerを外部ファイルで呼び出すプロバイダー.
final authAsyncNotifierController = AsyncNotifierProvider(AuthController.new);

// FirebaseAuthをインスタンス化したプロバイダー.
final authRepositoryProvider =
Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

class AuthController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // 値を返す（返り値が void ならば何もしない）。
  }
  // 匿名認証でログインするメソッド
  Future<void> signInAnonymously(BuildContext context) async {
    final authRepository = ref.read(authRepositoryProvider);
    // ボタンを押すと、ローディングの処理が表示される
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.signInAnonymously);
    // 非同期処理の中にBuildContextのコードがあるとLintの警告が出るので、mounted
    // の中に処理を書いて警告を消す。
    if (context.mounted) {
      // pushAndRemoveUntilを使うと、AppBarに戻るボタンが表示されなくなる
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>  HomePage()),
              (route) => true);
    }
  }


// // ログアウトするメソッド.
  // Future<void> signOutAnonymously(BuildContext context) async {
  //   final authRepository = ref.read(authRepositoryProvider);
  //   state = const AsyncValue.loading();
  //   state = await AsyncValue.guard(() => authRepository.signOut());
  //   if (context.mounted) {
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (context) => const SignInPage()),
  //             (route) => false);
  //   }
  // }
}