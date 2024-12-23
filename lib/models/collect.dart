import 'package:cloud_firestore/cloud_firestore.dart';

class Collect{
  final String documentId;
  String identification;
  final DateTime createdAt;
  final String scannerName;
  final String scannerId;
  final String farmAddress;
  final String farmName;
  final String affiliation;

  Collect({
    required this.documentId,
    required this.identification,
    required this.createdAt,
    required this.scannerName,
    required this.scannerId,
    required this.farmAddress,
    required this.farmName,
    required this.affiliation,
  });

  factory Collect.fromMap(Map<String, dynamic> map){
    return Collect(
      documentId: map['documentId'],
      identification: map['identification'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      scannerName: map['scannerName'],
      scannerId: map['scannerId'],
      farmAddress: map['address'],
      farmName: map['farmName'],
      affiliation: map['affiliation'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'documentId': documentId,
      'identification': identification,
      'createdAt': createdAt,
      'scannerName': scannerName,
      'scannerId': scannerId,
      'address': farmAddress,
      'farmName': farmName,
      'affiliation': affiliation,
    };
  }
}