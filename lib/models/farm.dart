class Farm{
  final String documentId;
  final String farmName;
  final String address;

  Farm({
    required this.documentId,
    required this.farmName,
    required this.address,
  });

  factory Farm.fromMap(Map<String, dynamic> map){
    return Farm(
      documentId: map['documentId'],
      farmName: map['farmName'],
      address: map['address'],
    );
  }

  Map toMap(){
    return {
      'documentId': documentId,
      'farmName': farmName,
      'address': address,
    };
  }
}