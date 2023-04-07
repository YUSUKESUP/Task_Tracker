import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/withdrawal.dart';
import '../utils/app_state.dart';

class SimpleDialogPage extends ConsumerWidget {
  const SimpleDialogPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  CupertinoAlertDialog(
      title: Text('退会してもよろしいですか？'),
      content: Text('データは全て消去されます。'),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: Text('キャンセル'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text('退会する'),
          onPressed: () async{
            ref
                .read(appStateProvider
                .notifier)
            .deleteUser();
            print('ユーザーを削除しました!');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const WithdrawalPage()));
          },
        ),
      ],
    );
  }
}