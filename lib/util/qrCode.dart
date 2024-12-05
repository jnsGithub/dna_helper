import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dna_helper/models/collect.dart';

class QrCode{
  final db = FirebaseFirestore.instance;

  // QR코드 세팅
  Future<void> qrCodeSetting(List<Collect> collect) async {
    try {
      for(int i = 0; i < collect.length; i++){
        Map<String, dynamic> data = collect[i].toMap();
        data['isDownloaded'] = false;
        data['identification'] = '002${collect[i].identification}';
        await db.collection('qrCode').doc(collect[i].documentId).update(data);
      }
    } catch (e) {
      print('QR코드 세팅할때 걸림');
      print(e);
    }
  }

  // QR코드 체크
  Future<bool> checkQR(String qrCode) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await db.collection('qrCode').doc(qrCode).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if(data.isEmpty && snapshot.exists){
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