import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';

import '../../presentation/widget/forced_update_dialog.dart';




final packageInfoProvider = FutureProvider((_) =>  PackageInfo.fromPlatform());

final versionCheckDialogProvider = Provider((ref) => VersionCheckDialog());

class VersionCheckDialog {


  ///強制アップデート

  Future<void> versionCheck(BuildContext context, WidgetRef ref) async {

    ///アプリのバージョンを取得
    final info = await ref.read(packageInfoProvider.future);
    final currentVersion = Version.parse(info.version);


    ///Firestoreからアップデートしたいバージョンを取得
    final versionDates = await FirebaseFirestore.instance
        .collection('config')
        .doc('nu7t69emUsaxYajqJEEE')
        .get();
    ///ios
    final iosAppVersion =
    Version.parse(versionDates.data()!['ios_force_app_version'] as String);
    ///android
    final androidAppVersion =
    Version.parse(versionDates.data()!['android_force_app_version'] as String);

    if (Platform.isIOS && currentVersion < iosAppVersion) {
      showUpdateDialog(context);
    } else if (Platform.isAndroid && currentVersion < androidAppVersion) {
      showUpdateDialog(context);
    }
  }

  /// ダイアログを表示
  void showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return ForcedUpdateDialogPage(
            title: 'バージョン更新のお知らせ',
            message: '新しいバージョンのアプリが利用可能です。ストアより更新版を入手して、ご利用下さい',
            btnLabel: '今すぐ更新');
      },
    );
  }




}


