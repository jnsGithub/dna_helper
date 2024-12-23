import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dna_helper/global.dart';
import 'package:dna_helper/models/myInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Sign{
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;



  // 회원가입
  Future<bool> signUp(String email, String password, String name, String affiliation) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(email: email, password: password);
      if(userType == '실험자'){
        await db.collection('users').doc(user.user!.uid).set({
          'email': email,
          'userType': userType,
          'affiliation': affiliation,
          'name': name,
          'selectedFarmName': '',
          'selectedFarmAddress': '',
          'isApproved': false,
        });
        return false;
      }
      else {
        await db.collection('users').doc(user.user!.uid).set({
          'email': email,
          'userType': userType,
          'affiliation': affiliation,
          'name': name,
          'selectedFarmName': '',
          'selectedFarmAddress': '',
        });
      }
      myInfo = MyInfo(
        documentId: user.user!.uid,
        name: name,
        userType: userType,
        email: email,
        selectedFarmName: '',
        selectedFarmAddress: '',
        affiliation: affiliation,
      );
      return true;
    } catch (e) {
      print('회원가입 에러');
      print(e);
      return false;
    }
  }

  // 로그인
  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot snapshot = await db.collection('users').doc(user.user!.uid).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      data['documentId'] = snapshot.id;
      myInfo = MyInfo.fromMap(data);
      print(myInfo.selectedFarmAddress);
      print(myInfo.selectedFarmName);

      if(myInfo.userType == '실험자'){
        if(!myInfo.isApproved!){
          Get.back();
          if(!Get.isSnackbarOpen) {
            Get.snackbar('실험자 승인 대기중', '실험자 승인 대기중입니다.');
          }
          return false;
        }
      }
      return true;
    } catch (e) {
      print('로그인 에러');
      print(e);
      Get.back();
      if(!Get.isSnackbarOpen) {
        Get.snackbar('로그인 에러', '이메일 및 비밀번호를 확인해주세요.');
      }
      return false;
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    try {
      uid = '';
      myInfo = MyInfo(
        documentId: '',
        name: '',
        userType: '',
        email: '',
        selectedFarmName: '',
        selectedFarmAddress: '',
        affiliation: '',
      );
      await auth.signOut();
      print(uid);
    } catch (e) {
      print('로그아웃 에러');
      print(e);
    }
  }

  // 비밀번호 재설정
  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('비밀번호 재설정 에러');
      print(e);
    }
  }
}