import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dna_helper/global.dart';
import 'package:dna_helper/models/affiliation.dart';
import 'package:dna_helper/models/collect.dart';
import 'package:dna_helper/models/farm.dart';
import 'package:dna_helper/view/mainView/home/homeController.dart';
import 'package:get/get.dart';

class MainData{
  final db = FirebaseFirestore.instance;

  // 소속 리스트 가져오기
  Future<List<Affiliation>> getAffiliationList() async {
    List<Affiliation> affiliationList = [];
    try {
      QuerySnapshot snapshot = await db.collection('affiliation').get();
      for (QueryDocumentSnapshot document in snapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        data['documentId'] = document.id;
        affiliationList.add(Affiliation.fromMap(data));
      }
      return affiliationList;
    } catch (e) {
      print('소속 리스트 가져올때 걸림');
      print(e);
      return [];
    }
  }

  // 소속 업데이트
  updateAffiliation(String affiliation) async {
    try {
      await db.collection('users').doc(myInfo.documentId).update({
        'affiliation': affiliation,
      });
      if(!Get.isSnackbarOpen){
        Get.snackbar('변경 완료', '소속 기관이 변경 완료되었습니다.');
      }
    } catch (e) {
      print('소속 업데이트 실패');
      print(e);
    }
  }

  // 농장 리스트 가져오기
  Future<List<Farm>>getFarmList() async {
    List<Farm> farmList = [];
    try {
      QuerySnapshot snapshot = await db.collection('users').doc(myInfo.documentId).collection('farm').orderBy('createAt', descending: true).get();
      for (QueryDocumentSnapshot document in snapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        data['documentId'] = document.id;
        data['createAt'] = (data['createAt'] as Timestamp).toDate();
        farmList.add(Farm.fromMap(data));
      }
      return farmList;
    } catch (e) {
      print('농장 리스트 가져올때 걸림');
      print(e);
      return [];
    }
  }

  // 농장 추가
  addFarm(String farmName, String farmAddress) async {
    try {
      QuerySnapshot snapshot = await db.collection('users').doc(myInfo.documentId).collection('farm').get();
      await db.collection('users').doc(myInfo.documentId).collection('farm').add({
        'farmName': farmName,
        'farmAddress': farmAddress,
        'createAt': DateTime.now(),
      });
      if(snapshot.docs.length == 0){
        myInfo.selectedFarmName = farmName;
        myInfo.selectedFarmAddress = farmAddress;
        await updateFarm(myInfo.documentId, farmName, farmAddress);
        var controller = Get.find<HomeController>();
        await init();
        await controller.init();
      }
    } catch (e) {
      print('농장 추가 실패');
      print(e);
    }
  }

  // 선택한 농장 업데이트
  updateFarm(String documentId, String farmName, String farmAddress) async {
    try {
      await db.collection('users').doc(myInfo.documentId).update({
        'selectedFarmName': farmName,
        'selectedFarmAddress': farmAddress,
      });
    } catch (e) {
      print('농장 업데이트 실패');
      print(e);
    }
  }

  // 농장 삭제
  deleteFarm(String documentId, String farmName, String farmAddress) async {
    try {
      await db.collection('users').doc(myInfo.documentId).collection('farm').doc(documentId).delete();
      QuerySnapshot snapshot = await db.collection('users').doc(myInfo.documentId).collection('farm').get();

      if(myInfo.selectedFarmAddress == farmAddress && myInfo.selectedFarmName == farmName && snapshot.docs.length != 0){
        List<Farm> farmList = await getFarmList();
        myInfo.selectedFarmName = farmList[0].farmName;
        myInfo.selectedFarmAddress = farmList[0].farmAddress;
        await db.collection('users').doc(myInfo.documentId).update({
          'selectedFarmName': farmList[0].farmName,
          'selectedFarmAddress': farmList[0].farmAddress,
        });
      }

      if(snapshot.docs.length == 0){
        myInfo.selectedFarmName = '';
        myInfo.selectedFarmAddress = '';
        await db.collection('users').doc(myInfo.documentId).update({
          'selectedFarmName': '',
          'selectedFarmAddress': '',
        });
      }
      var controller = Get.find<HomeController>();
      await init();
      await controller.init();
    } catch (e) {
      print('농장 삭제 실패');
      print(e);
    }
  }

  Future<List<Collect>> getMyCollection() async {
    try{
      List<Collect> collectList = [];
      QuerySnapshot snapshot = await db.collection('qrCode').where('scannerId', isEqualTo: myInfo.documentId).orderBy('createdAt', descending: true).get();
      for(QueryDocumentSnapshot document in snapshot.docs){
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        data['documentId'] = document.id;
        collectList.add(Collect.fromMap(data));
      }
      print(collectList.length);
      return collectList;

    } catch(e){
      print('내 수집물 가져오기 실패');
      print(e);
      return [];
    }
  }
}