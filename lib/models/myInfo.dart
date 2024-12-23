class MyInfo{
  final String documentId;
  final String name;
  final String userType;
  final String email;
  String? selectedFarmName;
  String? selectedFarmAddress;
  String affiliation;
  bool? isApproved;

  MyInfo({
    required this.documentId,
    required this.name,
    required this.userType,
    required this.email,
    required this.selectedFarmName,
    required this.selectedFarmAddress,
    required this.affiliation,
    this.isApproved,
  });

  factory MyInfo.fromMap(Map<String, dynamic> map){
    return MyInfo(
      documentId: map['documentId'],
      name: map['name'],
      userType: map['userType'],
      email: map['email'],
      selectedFarmName: map['selectedFarmName'] ?? '',
      selectedFarmAddress: map['selectedFarmAddress'] ?? '',
      affiliation: map['affiliation'],
      isApproved: map['isApproved'],
    );
  }

  Map toMap(){
    return {
      'documentId': documentId,
      'name': name,
      'userType': userType,
      'email': email,
      'selectedFarmName': selectedFarmName,
      'selectedFarmAddress': selectedFarmAddress,
      'affiliation': affiliation,
      'isApproved': isApproved,
    };
  }
}