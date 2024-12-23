import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dna_helper/global.dart';
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

  Future<Collect?> getCollect(String docId) async{
    try{
      DocumentSnapshot<Map<String, dynamic>> snapshot = await db.collection('qrCode').doc(docId).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if(data['scannerName'] == null){
        return null;
      }
      return Collect.fromMap(data);
    } catch(e){
      print('getCollect 에러');
      print(e);
      return null;
    }
  }

  // QR코드 체크
  Future<bool> checkQR(String qrCode) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await db.collection('qrCode').doc(qrCode).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if(data.isEmpty && snapshot.exists || data['scannerName'] == null){
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

  Future<List<Collect>> getTempQrCode() async {
    List<Collect> list = [];
    try{
      QuerySnapshot<Map<String, dynamic>> snapshot = await db.collection('users').doc(myInfo.documentId).collection('tempQrCode').get();
      if(snapshot.docs.isEmpty){
        return [];
      }
      for(QueryDocumentSnapshot<Map<String, dynamic>> document in snapshot.docs){
        Map<String, dynamic> data = document.data();
        data['documentId'] = document.id;
        list.add(Collect.fromMap(data));
      }
      return list;
    } catch(e){
      print('getTempQrCode 에러');
      print(e);
      return [];
    }
  }

  Future<void> tempSave(List<Collect> list) async{
    try{
      await db.collection('users').doc(myInfo.documentId).collection('tempQrCode').get().then((value) {
        for(DocumentSnapshot<Map<String, dynamic>> document in value.docs){
          document.reference.delete();
        }
      });
      for(int i = 0; i < list.length; i++){
        await db.collection('users').doc(myInfo.documentId).collection('tempQrCode').doc(list[i].documentId).set(list[i].toMap());
      }
    } catch(e){
      print('tempSave 에러');
      print(e);
    }
  }

  Future<void> tempDelete(String docId) async{
    try{
      await db.collection('users').doc(myInfo.documentId).collection('tempQrCode').doc(docId).delete();
    } catch(e){
      print('tempDelete 에러');
      print(e);
    }
  }
}