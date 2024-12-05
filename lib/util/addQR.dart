import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class QrCodeUploader {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> generateAndUploadQRCode(int count) async {
    try {
      // 1. Firestore에 documentID 저장
      for(int i = 0; i < count; i++){
        await db.collection('qrCode').doc().set({});
      }

      // QuerySnapshot<Map<String, dynamic>> snapshot = await db.collection('qrCode').get();

      // for(var i in snapshot.docs){
      //   if(i.data().isEmpty){
      //     String documentID = i.id;
      //     // 2. QR 코드 생성
      //     final qrPainter = QrPainter(
      //       data: '1',
      //       version: QrVersions.auto,
      //       gapless: false,
      //     );
      //
      //     // 3. QR 코드를 PNG로 변환
      //     final tempDir = await getTemporaryDirectory();
      //     final qrFile = File('${tempDir.path}/$documentID.png');
      //     final ByteData? qrImageData = await qrPainter.toImageData(2048, format: ImageByteFormat.png);
      //     if (qrImageData != null) {
      //       await qrFile.writeAsBytes(qrImageData.buffer.asUint8List());
      //     }
      //
      //     // 4. Firebase Storage에 업로드
      //     final storageRef = storage.ref().child('qr_codes/$documentID.png');
      //     await storageRef.putFile(qrFile);
      //
      //     // 5. QR 코드 URL 가져오기
      //     final downloadURL = await storageRef.getDownloadURL();
      //
      //     await db.collection('qrCode').doc(i.id).update({'qrCodeURL': downloadURL});
      //     // 6. Firestore에 QR 코드 URL 저장
      //     // i.data()['qrCodeURL'] = downloadURL;
      //
      //     debugPrint('QR Code uploaded successfully: $downloadURL');
      //   }
      //   }
      Get.back();
      }
    catch (e) {
      debugPrint('Error generating or uploading QR Code: $e');
      Get.back();
    }

  }
}
