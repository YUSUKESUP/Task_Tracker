import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/provider/app_methods.dart';
import '../../application/provider/firebase_provider.dart';
import '../widget/withdrawal_dialog.dart';

class SettingPage extends ConsumerWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final firebaseNotifications = ref.watch(firebaseNotificationsProvider);

    final appMethod = memoRepositoryProvider;

    ///退会ダイアログ
    Future<void> withdrawalDialog() async {
      await showDialog(
          context: context,
          builder: (_) {
            return  WithdrawalDialogPage();
          });
    }

    const divider = Divider(
      thickness: 2,
      height: 0,
      color: Colors.black12,
    );

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            '設定',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              trailing: CupertinoSwitch(
                activeColor: Colors.pink,
                trackColor: Colors.blueGrey,
                value: firebaseNotifications.valueOrNull?.
                data()?['shouldNotification'] ?? false,
                onChanged: (value) async {
                  ref
                      .read(appMethod)
                      .upDateSwitch(value);
                },
              ),
              title: const Text('リマインド'),
            ),
            divider,
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: withdrawalDialog,
              child: Container(
                height: 55,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    '退会',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
