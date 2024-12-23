class Farm{
  final String documentId;
  final String farmName;
  final String farmAddress;
  final DateTime createAt;

  Farm({
    required this.documentId,
    required this.farmName,
    required this.farmAddress,
    required this.createAt,
  });

  factory Farm.fromMap(Map<String, dynamic> map){
    return Farm(
      documentId: map['documentId'],
      farmName: map['farmName'],
      farmAddress: map['farmAddress'],
      createAt: map['createAt'],

    );
  }

  Map toMap(){
    return {
      'documentId': documentId,
      'farmName': farmName,
      'address': farmAddress,
      'createAt': createAt,
    };
  }
}