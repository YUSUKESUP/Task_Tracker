import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String text,
    required DateTime createdAt,
    required bool isDone,
  }) = _Task;

  factory Task.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw StateError('Missing features for document ${snapshot.id}');
    }
    return Task(
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
