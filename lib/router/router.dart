//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
//
//
// final routerProvider = Provider<GoRouter>((ref) {
//   return GoRouter(
//     initialLocation:  '/',
//     routes: [
//       GoRoute(
//           path: '/',
//           builder: (context, state) => const HomePage(),
//           routes: [
//             GoRoute(
//               path: 'notification',
//               builder: (context, state) => const NotificationPage(),
//             ),
//             GoRoute(
//               path: 'auth',
//               builder: (context, state) => const AuthPage(),
//             ),
//             GoRoute(
//               path: 'fargot',
//               builder: (context, state) => const FargotPassword(),
//             ),
//             GoRoute(
//               path: 'lists',
//               builder: (context, state) => const SettingList(),
//             ),
//             GoRoute(
//               path: 'settingNotification',
//               builder: (context, state) => const SettingNotificationPage(),
//             ),
//           ]
//       ),
//     ],
//   );
// });
//
