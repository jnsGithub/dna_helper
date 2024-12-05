import 'package:dna_helper/component/widget.dart';
import 'package:dna_helper/global.dart';
import 'package:dna_helper/view/mainView/myPage/myPageView.dart';
import 'package:dna_helper/view/mainView/qrScan/qrScanView.dart';
import 'package:dna_helper/view/testerMainView/testerHome/testerHomeController.dart';
import 'package:dna_helper/view/testerMainView/testerSampleDB/testerSampleDBView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TesterHomeView extends GetView<TesterHomeController> {
  const TesterHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TesterHomeController());
    Size size = MediaQuery.of(context).size;

    return Obx(() => Scaffold(
        appBar: controller.selectedIndex.value == 0 ? AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image(image: AssetImage('assets/images/miniLogo.png'), width: 36, height: 36,),
              const SizedBox(width: 10,),
              Text('가축 DNA 채취 도우미', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)
            ],
          ),
        ) : null,
        body: controller.selectedIndex.value == 0
            ? TesterSampleDBView()
        : controller.selectedIndex.value == 1 ? QrScanView() : MyPageView(),
        bottomNavigationBar: bottomNavi(context, controller.selectedIndex, size),
      ),
    );
  }
}
