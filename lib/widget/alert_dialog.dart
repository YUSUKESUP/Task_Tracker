import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertDialogPage extends StatefulWidget {

  final String title;
  final String message;
  final String btnLabel;

   const AlertDialogPage({
       Key? key,
    required this.title,
    required this.message,
    required this.btnLabel,
  })
      : super(key: key);

  @override
  State<AlertDialogPage> createState() => _AlertDialogPageState();
}

class _AlertDialogPageState extends State<AlertDialogPage> {

  // FIXME ストアにアプリを登録したらurlが入れられる
  final  appStoreURL = Uri.parse('https://apps.apple.com/jp/app/id[アプリのApple ID]?mt=8');


  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title:  Text(widget.title),
      content:  Text(widget.message),
      actions: <Widget>[
        TextButton(
          child:  Text(
            widget.btnLabel,
            style: TextStyle(color: Colors.red),
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
