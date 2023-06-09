import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_crud/presentation/theme/color.dart';
import 'package:firebase_crud/presentation/widget/tabs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'application/provider/version_check.dart';
import 'infrastructure/firebase/firebase_options.dart';

void main() async {

  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    ///匿名ログイン(UIDとドキュメントIDを一致させる)
    final firebaseUser = await FirebaseAuth.instance.userChanges().first;

    if (firebaseUser == null) {
      /// 未サインインなら匿名ユーザーでサインイン
      final credential = await FirebaseAuth.instance.signInAnonymously();
      final uid = credential.user!.uid;
      final users = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({'uid': uid, 'shouldNotification': false});
    }

    ///プッシュ通知
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    ///トークンを取得
    final token = await messaging.getToken();

    ///取得したトークンをセット
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    if (uid != null) {
      final setToken = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({'fcmToken': token}, SetOptions(merge: true));
    }

    ///Flutterでキャッチされた例外/エラー
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(
      const ProviderScope(child: MyApp()),
    );
  }, (error, stackTrace) {
    ///Flutterでキャッチされなかった例外/エラー
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    ref.read(versionCheckDialogProvider);
  }


  @override
  Widget build(
    BuildContext context,) {
    return  MaterialApp(
      theme: ThemeData(
        primaryColor:AppColors.primaryColor,
        scaffoldBackgroundColor:AppColors.backgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      home: TabsPage(),
    );
  }
}
