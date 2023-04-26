import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForcedUpdateDialogPage extends StatelessWidget {
  final String title;
  final String message;
  final String btnLabel;

  ForcedUpdateDialogPage({
    Key? key,
    required this.title,
    required this.message,
    required this.btnLabel,
  }) : super(key: key);

  /// ios
  final appStoreURL =
      Uri.parse('https://apps.apple.com/jp/app/%E3%82%BF%E3%82%B9%E3%82%AF%E3%83%88%E3%83%A9%E3%83%83%E3%82%AB%E3%83%BC/id6447428420');

  /// android
  final googlePlayURL =
  Uri.parse('https://play.google.com/store/apps/details?id=com.domain.firebase_crud');


  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text(
            btnLabel,
            style: const TextStyle(color: Colors.red),
          ),
          onPressed: () async {
            if (Platform.isAndroid) {
              await launchUrl(
                googlePlayURL,
                mode: LaunchMode.externalApplication,
              );
            } else if (Platform.isIOS)  {
              await launchUrl(
                  appStoreURL,
                  mode: LaunchMode.externalApplication);
                  }
            else {
              throw 'Could not Launch $appStoreURL';// URLが無効の場合はエラーをスロー
            }
          },
        ),
      ],
    );
  }
}
