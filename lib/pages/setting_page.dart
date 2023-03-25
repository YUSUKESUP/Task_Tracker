// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../router/router.dart';
//
// class SettingPage extends ConsumerWidget {
//   const SettingPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     const divider = Divider(
//       thickness: 2,
//       height: 0,
//       color: Colors.black12,
//     );
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('設定一覧'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Container(
//             alignment: Alignment.centerLeft,
//             color: Colors.grey[200],
//             height: 60,
//             child: const Padding(
//               padding: EdgeInsets.only(left: 10.0),
//               child: Text('アカウント',
//                   style: TextStyle(
//                     fontSize: 15,
//                   )),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               children: [
//                 ListTile(
//                   onTap: () {
//                     ref.watch(routerProvider).push('/settingNotification');
//                   },
//                   leading: const Icon(Icons.notifications),
//                   trailing: const Icon(Icons.arrow_forward_ios),
//                   title: const Text('通知の設定'),
//                 ),
//                 divider,
//                 ListTile(
//                   onTap: () {
//                     ref.watch(routerProvider).push('/fargot');
//                   },
//                   leading: const Icon(Icons.lock),
//                   trailing: const Icon(Icons.arrow_forward_ios),
//                   title: const Text('パスワード再設定'),
//                 ),
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   color: Colors.grey[200],
//                   height: 60,
//                   child: const Padding(
//                     padding: EdgeInsets.only(left: 10.0),
//                     child: Text('その他',
//                         style: TextStyle(
//                           fontSize: 15,
//                         )),
//                   ),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     final url = Uri.parse('https://forms.gle/vzK7tKT9oMDJdcNs5');
//                     launchUrl(url,mode: LaunchMode.externalApplication);
//                   },
//                   title: const Text('問い合わせ'),
//                 ),
//                 divider,
//                 ListTile(
//                   onTap: () async {
//                     final url = Uri.parse('https://github.com/YUSUKESUP/medicineRemainder');
//                     launchUrl(url);
//                   },
//                   title: const Text('プライバシーポリシー'),
//                 ),
//                 divider,
//                 ListTile(
//                   onTap: () async {
//                     final url = Uri.parse('https://irradiated-corn-f2a.notion.site/8890b7531d2342b9b760fa270e044268');
//                     launchUrl(url,mode: LaunchMode.externalApplication);
//                   },
//                   title: const Text('利用規約'),
//                 ),
//                 divider,
//                 ListTile(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const WithdrawalPage()));
//                   },
//                   title: const Text('退会機能'),
//                 ),
//                 divider,
//                 ListTile(
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: Text('ログアウトしてもいいですか？'),
//                           content: Text('キャンセルを押した場合、処理を中断します。'),
//                           actions: [
//                             TextButton(
//                               child: Text('キャンセル'),
//                               onPressed: () => Navigator.pop(context),
//                             ),
//                             TextButton(
//                               child: Text('OK'),
//                               onPressed: () async {
//                                 // ログアウト処理
//                                 // 内部で保持しているログイン情報等が初期化される
//                                 await FirebaseAuth.instance.signOut();
//                                 context.push('/');
//                               },
//                             )
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   title: const Text('ログアウト'),
//                 ),
//                 divider,
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   color: Colors.grey[200],
//                   height: 600,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
