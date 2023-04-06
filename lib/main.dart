import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/widget/alert_dialog.dart';
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
     const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    versionCheck();
  }

  //強制アップデート
  Future<void> versionCheck() async {

    /// ダイアログを表示
    void showUpdateDialog(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return  AlertDialogPage(
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
    print(currentVersion);

    //Firestoreからアップデートしたいバージョンを取得
    final versionDates = await FirebaseFirestore.instance
        .collection('config')
        .doc('nu7t69emUsaxYajqJEEE')
        .get();
    final  newVersion =  Version.parse(versionDates.data()!['ios_force_app_version'] as String);

    //バージョンを比較し、現在のバージョンの方が低ければダイアログを出す
    if (currentVersion < newVersion) {
      showUpdateDialog(context);
    }
  }


  @override
  Widget build(BuildContext context,) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabsPage(),
    );
  }
}



