import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo.freezed.dart';

@freezed
class Memo with _$Memo {
  const factory Memo({
    required String text,
    required DateTime createdAt,
    required bool isDone,
  }) = _Memo;

  factory Memo.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw StateError('Missing data for document ${snapshot.id}');
    }
    return Memo(
      text: data['text'] as String,
      createdAt: (data['createdAt'] as Timestamp? )?.toDate() ?? DateTime.now(),
      isDone: data['isDone'] as bool,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'text': text,
      'createdAt': Timestamp.fromDate(createdAt),
      'isDone': isDone,
    };
  }
}
