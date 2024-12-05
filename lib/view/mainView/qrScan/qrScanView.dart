import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:dna_helper/global.dart';
import 'package:dna_helper/models/collect.dart';
import 'package:dna_helper/util/qrCode.dart';
import 'package:dna_helper/view/mainView/home/homeController.dart';
import 'package:dna_helper/view/mainView/sampleDB/sampleDBController.dart';
import 'package:dna_helper/view/testerMainView/testerHome/testerHomeController.dart';
import 'package:dna_helper/view/testerMainView/testerSampleDB/testerSampleDBController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrScanView extends StatefulWidget {
  const QrScanView({super.key});

  @override
  State<QrScanView> createState() => _QrScanViewState();
}

class _QrScanViewState extends State<QrScanView> {
  String barcode = 'Tap  to scan';
  @override
  Widget build(BuildContext context) {
    return AiBarcodeScanner(
      onDispose: () {
        /// This is called when the barcode scanner is disposed.
        /// You can write your own logic here.
        debugPrint("Barcode scanner disposed!");
      },
      hideGalleryButton: true,
      hideSheetTitle: true,
      hideSheetDragHandler: true,
      successColor: Colors.green,
      showSuccess: true,
      errorColor: Colors.limeAccent,
      overlayColor: Colors.blue.withOpacity(0.7),

      controller: MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
      ),
      onDetect: (BarcodeCapture capture) async {
        /// The row string scanned barcode value
        final String? scannedValue =
            capture.barcodes.first.rawValue;
        debugPrint("Barcode scanned: $scannedValue");

        /// The `Uint8List` image is only available if `returnImage` is set to `true`.
        // final Uint8List? image = capture.image;
        // debugPrint("Barcode image: $image");

        /// row data of the barcode
        // final Object? raw = capture.raw;
        // debugPrint("Barcode raw: $raw");

        /// List of scanned barcodes if any
        // final List<Barcode> barcodes = capture.barcodes;
        // debugPrint("Barcode list: $barcodes");
        
        QrCode qrCheck = QrCode();
        if(userType == '실험자') {
          var controller = Get.find<TesterSampleDBController>();
          var controller2 = Get.find<TesterHomeController>();
          controller.isExist.value = true;
          controller2.selectedIndex.value = 0;
          Get.offAllNamed('/testerHomeView');
        }
        else {
          if(await qrCheck.checkQR(scannedValue!)){
            print('QR코드에 정보가 없음');
            var controller = Get.find<SampleDBController>();
            var controller2 = Get.find<HomeController>();
            controller2.selectIndex.value = 0;
            controller.addCollect(
                Collect(documentId: scannedValue, identification: '', createdAt: DateTime.now(), name: myInfo.name, farmAddress: myInfo.selectedFarmAddress!, farmName: myInfo.selectedFarmName!)
            );
          }
          // Get.offAllNamed('/homeView');
        }
      },
      validator: (value) {
        if (value.barcodes.isEmpty) {
          return false;
        }
        if (!(value.barcodes.first.rawValue
            ?.contains('flutter.dev') ??
            false)) {
          return false;
        }
        return true;
      },
    );
  }
}