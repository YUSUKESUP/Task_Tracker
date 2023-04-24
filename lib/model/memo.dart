// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'memo.freezed.dart';
//
// @freezed
// class Memo with _$Memo {
//   const factory Memo({
//     required String id,
//     required String title,
//     required String content,
//     required DateTime createdAt,
//   }) = _Memo;
//
//   factory Memo.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
//     final data = snapshot.data();
//     if (data == null) {
//       throw StateError('Missing data for document ${snapshot.id}');
//     }
//     return Memo(
//       id: snapshot.id,
//       title: data['title'] as String,
//       content: data['content'] as String,
//       createdAt: (data['createdAt'] as Timestamp).toDate(),
//     );
//   }
//
//   Map<String, dynamic> toDocument() {
//     return {
//       'title': title,
//       'content': content,
//       'createdAt': Timestamp.fromDate(createdAt),
//     };
//   }
// }
//
//
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // class Memo {
// //
// //   final String text;
// //
// //   final bool isDone;
// //
// //   final Timestamp createdAt;
// //   final DocumentReference reference;
// //
// //   factory Memo.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
// //     final map = snapshot.data()!;
// //
// //
// //     return Memo(
// //       text: map['text'],
// //       createdAt: map['createdAt'],
// //       isDone: map['isDone'],
// //       reference: snapshot.reference,
// //     );
// //   }
// //
// //   Map<String, dynamic> toMap() {
// //     return {
// //       'text': text,
// //       'createdAt': createdAt,
// //       'isDone':isDone,
// //     };
// //   }
// //
// //
// //   Memo({
// //     required this.text,
// //     required this.isDone,
// //     required this.createdAt,
// //     required this.reference
// //
// //   });
// // }
//
//
// // import 'package:clinic_test_app/shared/enum/app_tag.dart';
// // import 'package:freezed_annotation/freezed_annotation.dart';
// // part 'clinic.g.dart';
// // part 'clinic.freezed.dart';
// //
// // @freezed
// // class Clinic with _$Clinic {
// //   const factory Clinic({
// //     required String image,
// //     required String name,
// //     required String address,
// //     required AppTag tag,
// //   }) = _Clinic;
// //
// //   factory Clinic.fromJson(Map<String, dynamic> json) => _$ClinicFromJson(json);
// // }