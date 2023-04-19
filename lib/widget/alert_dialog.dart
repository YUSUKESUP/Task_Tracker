import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertDialogPage extends StatelessWidget {
  final String title;
  final String message;
  final String btnLabel;

  AlertDialogPage({
    Key? key,
    required this.title,
    required this.message,
    required this.btnLabel,
  }) : super(key: key);

  // FIXME ストアにアプリを登録したらurlが入れられる
  final appStoreURL =
      Uri.parse('https://apps.apple.com/jp/app/%E3%82%BF%E3%82%B9%E3%82%AF%E3%83%88%E3%83%A9%E3%83%83%E3%82%AB%E3%83%BC/id6447428420');

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
            if (await canLaunchUrl(appStoreURL)) {
              await launchUrl(
                appStoreURL,
                mode: LaunchMode.externalApplication,
              );
              // URLが無効の場合はエラーをスロー
            } else {
              throw 'Could not Launch $appStoreURL';
            }
          },
        ),
      ],
    );
  }
}
