import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/withdrawal.dart';

class SimpleDialogPage extends StatefulWidget {
  const SimpleDialogPage({Key? key}) : super(key: key);

  @override
  State<SimpleDialogPage> createState() => _SimpleDialogPageState();
}

class _SimpleDialogPageState extends State<SimpleDialogPage> {

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
    print('ユーザーを削除しました!');
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('退会してもよろしいですか?'),
      children: [
        SimpleDialogOption(
          child: Text('退会する'),
          onPressed: () async {
            deleteUser();
            print('ユーザーを削除しました!');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WithdrawalPage()));
          },
        ),
        SimpleDialogOption(
          child: Text('キャンセル'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}