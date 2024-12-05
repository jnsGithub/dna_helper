import 'package:cloud_firestore/cloud_firestore.dart';

class QRCheck{
  final db = FirebaseFirestore.instance;

  // QR코드 체크
  Future<bool> checkQR(String qrCode) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await db.collection('qrCode').doc(qrCode).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if(data.isEmpty){
        print('QR코드에 정보가 없음');
        print('도큐먼트는 존재함 ${snapshot.exists}');

        if(snapshot.exists){
          print('도큐먼트는 존재함 ${snapshot.exists}');
        }
        return true;
      }
      else{
        return false;
      }
    } catch (e) {
      print('QR코드 체크할때 걸림');
      print(e);
      return false;
    }
  }
}