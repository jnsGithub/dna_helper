import 'package:cloud_firestore/cloud_firestore.dart';

class Affiliation{
  final String documentId;
  final String affiliation;
  final DateTime createdAt;

  Affiliation({
    required this.documentId,
    required this.affiliation,
    required this.createdAt,
  });

  factory Affiliation.fromMap(Map<String, dynamic> map){
    return Affiliation(
      documentId: map['documentId'],
      affiliation: map['affiliation'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'documentId': documentId,
      'affiliation': affiliation,
      'createdAt': createdAt,
    };
  }
}