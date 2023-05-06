import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/provider/app_methods.dart';
import '../pages/withdrawal.dart';


class WithdrawalDialogPage extends ConsumerWidget {
   WithdrawalDialogPage({Key? key}) : super(key: key);

  final appMethod = memoRepositoryProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoAlertDialog(
      title: const Text('退会してもよろしいですか？'),
      content: const Text('データは全て消去されます。'),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: const Text('キャンセル'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: const Text('退会する'),
          onPressed: () async {
            ref.read(appMethod).deleteUser();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WithdrawalPage()));
          },
        ),
      ],
    );
  }
}
