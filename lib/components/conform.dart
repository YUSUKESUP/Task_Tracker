// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class ConformPage extends StatelessWidget {
//
//   final String buttonName;
//   final controller;
//   VoidCallback onPressed;
//
//    ConformPage({
//      Key? key,
//      required this.buttonName,
//      required this.controller,
//      required this.onPressed,
//    }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: SizedBox(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               keyboardType: TextInputType.emailAddress,
//               controller: controller,
//               decoration: InputDecoration(
//                 labelText: '文字を入力してください',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             InkWell(
//               onTap: () {
//                 onPressed;
//               },
//               child: Container(
//                 height: 65,
//                 decoration: BoxDecoration(
//                   color: Colors.indigo,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Center(
//                   child: Text(buttonName,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
