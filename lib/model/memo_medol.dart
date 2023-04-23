import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {

  final String text;

  final bool isDone;

  final Timestamp createdAt;
  final DocumentReference reference;

  factory Memo.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;


    return Memo(
      text: map['text'],
      createdAt: map['createdAt'],
      isDone: map['isDone'],
      reference: snapshot.reference,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'createdAt': createdAt,
      'isDone':isDone,
    };
  }


  Memo({
    required this.text,
    required this.isDone,
    required this.createdAt,
    required this.reference

  });
}