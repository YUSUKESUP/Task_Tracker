import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/firebase_provider.dart';



class SettingNotificationPage extends ConsumerWidget {
  SettingNotificationPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final  firebaseNotifications = ref.watch(firebaseNotificationsProvider);



    const divider = Divider(
      thickness: 2,
      height: 0,
      color: Colors.black12,
    );

    return Scaffold(
        backgroundColor: Color(0xffFDF3E6),
        appBar: AppBar(
          backgroundColor: Color(0xffFDF3E6), centerTitle: true,
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('通知設定ページ',
            style: TextStyle(color: Colors.black),
          ),

        ),
        body: ListView(
          children: [
            ListTile(
              trailing: CupertinoSwitch(
                activeColor: Colors.pink,
                trackColor: Colors.blueGrey,
                value: firebaseNotifications.valueOrNull?.data()?['shouldNotification'] ?? false,
                onChanged: (value) {
                 FirebaseFirestore.instance.collection('users').doc('uid').update({'shouldNotification':value});
                },
              ),
              title: Text('リマインド'),

            ),
            divider
          ]
        )
    );
  }
}