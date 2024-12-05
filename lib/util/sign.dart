import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dna_helper/global.dart';
import 'package:dna_helper/models/myInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Sign{
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  // 회원가입
  Future<bool> signUp(String email, String password, String name, String affiliation) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(email: email, password: password);
      await db.collection('users').doc(user.user!.uid).set({
        'email': email,
        'userType': userType,
        'affiliation': affiliation,
        'name': affiliation,
        'selectedFarm': '',
      });
      myInfo = MyInfo(
        documentId: user.user!.uid,
        name: name,
        userType: userType,
        selectedFarm: '',
        affiliation: affiliation,
      );
      uid = user.user!.uid;
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
      uid = user.user!.uid;

      return true;
    } catch (e) {
      print('로그인 에러');
      print(e);
      return false;
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    try {
      await auth.signOut();
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