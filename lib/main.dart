
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/utils/firebase_provider.dart';
import 'package:firebase_crud/widget/dialog.dart';
import 'package:firebase_crud/widget/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';

import 'firebase_options.dart';

void main() async {

  //firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //匿名ログイン(UIDとドキュメントIDを一致させる)
  final firebaseUser = await FirebaseAuth.instance.userChanges().first;

  if (firebaseUser == null) {
    // 未サインインなら匿名ユーザーでサインイン
    final credential = await FirebaseAuth.instance.signInAnonymously();

    final uid = credential.user!.uid;
    final users = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'uid': uid, 'shouldNotification': false});

  }



  runApp(
     ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, });

  @override
  Widget build(BuildContext context,) {



    //強制アップデート
    Future<void> versionCheck(dynamic document) async {

      /// ダイアログを表示
      void showUpdateDialog(BuildContext context) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const ShowDialog(
                title: 'バージョン更新のお知らせ',
                message: '新しいバージョンのアプリが利用可能です。ストアより更新版を入手して、ご利用下さい',
                btnLabel: '今すぐ更新'
            );
          },
        );
      }

      //アプリのバージョンを取得
      final info = await PackageInfo.fromPlatform();
      final currentVersion = Version.parse(info.version);

      //Firestoreからアップデートしたいバージョンを取得
      final versionDates = await FirebaseFirestore.instance
          .collection('users')
          .doc('')
          .get();
      final newVersion =  Version.parse(versionDates.data()!['ios_force_app_version'] as String);

      //バージョンを比較し、現在のバージョンの方が低ければダイアログを出す
      if (currentVersion < newVersion) {
        showUpdateDialog(context);
      }
    }


    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabsPage(),
    );
  }
}



