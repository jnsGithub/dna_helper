import 'package:cloud_firestore/cloud_firestore.dart';

class Collect{
  final String documentId;
  String identification;
  final DateTime createdAt;
  final String name;
  final String farmAddress;
  final String farmName;

  Collect({
    required this.documentId,
    required this.identification,
    required this.createdAt,
    required this.name,
    required this.farmAddress,
    required this.farmName,
  });

  factory Collect.fromMap(Map<String, dynamic> map){
    return Collect(
      documentId: map['documentId'],
      identification: map['identification'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      name: map['name'],
      farmAddress: map['address'],
      farmName: map['farmName'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'documentId': documentId,
      'identification': identification,
      'createdAt': createdAt,
      'name': name,
      'address': farmAddress,
      'farmName': farmName,
    };
  }
}