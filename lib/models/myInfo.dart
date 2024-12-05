class MyInfo{
  final String documentId;
  final String name;
  final String userType;
  String? selectedFarm;
  String affiliation;

  MyInfo({
    required this.documentId,
    required this.name,
    required this.userType,
    required this.selectedFarm,
    required this.affiliation,
  });

  factory MyInfo.fromMap(Map<String, dynamic> map){
    return MyInfo(
      documentId: map['documentId'],
      name: map['name'],
      userType: map['userType'],
      selectedFarm: map['selectedFarm'] ?? '',
      affiliation: map['affiliation'],
    );
  }

  Map toMap(){
    return {
      'documentId': documentId,
      'name': name,
      'userType': userType,
      'selectedFarm': selectedFarm,
      'affiliation': affiliation,
    };
  }
}