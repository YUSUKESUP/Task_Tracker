import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// AlertDialogWidgetのただのラッパーだと勘違いされる名前はやめよう。
/// 強制アップデートのために作られたWidgetであることがわかる名前をつけよう。
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
      Uri.parse('https://apps.apple.com/jp/app/id[6447428420]?mt=8');

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
            /// Androidのことを思い出してください。
            // Platform.isAndroid
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
