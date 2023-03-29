import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/auth_controll.dart';

// auth button that can be used for signing in or signing out
class AuthButton extends ConsumerWidget {
  const AuthButton({super.key, required this.text, required this.onPressed});
  final String text; // ボタンのタイトルを引数で渡す.
  final VoidCallback onPressed; // VoidCallback型を指定すると、ref.readを書くことができる.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listenを使ってプロバイダーをコールバック関数の引数に渡す.
    ref.listen<AsyncValue<void>>(
      authAsyncNotifierController,
          (_, state) {
        if (state.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.asError.toString())),
          );
        }
      },
    );
    final state = ref.watch(authAsyncNotifierController);
    return SizedBox(
      width: 200,
      height: 60,
      child: ElevatedButton(
        onPressed: state.isLoading ? null : onPressed,
        child: state.isLoading
            ? const CircularProgressIndicator()
            : Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}