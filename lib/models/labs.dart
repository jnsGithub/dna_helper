class Labs{
  final String documentId;
  final String title;

  Labs({
    required this.documentId,
    required this.title,
  });

  factory Labs.fromMap(Map<String, dynamic> map){
    return Labs(
      documentId: map['documentId'],
      title: map['title'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'documentId': documentId,
      'title': title,
    };
  }
}