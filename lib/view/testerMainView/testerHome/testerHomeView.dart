import 'package:dna_helper/component/widget.dart';
import 'package:dna_helper/global.dart';
import 'package:dna_helper/view/mainView/myPage/myPageView.dart';
import 'package:dna_helper/view/mainView/qrScan/qrScanView.dart';
import 'package:dna_helper/view/testerMainView/testerHome/testerHomeController.dart';
import 'package:dna_helper/view/testerMainView/testerSampleDB/testerSampleDBView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TesterHomeView extends GetView<TesterHomeController> {
  const TesterHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TesterHomeController());
    Size size = MediaQuery.of(context).size;
    DateTime? _lastPressedAt; // 마지막으로 뒤로가기를 누른 시간

    return Obx(() => PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool, dynamic) async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt!) > const Duration(seconds: 1)) {
          // 뒤로가기 버튼이 처음 눌렸거나, 마지막 클릭 이후 2초가 지나면 시간을 갱신
          _lastPressedAt = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('뒤로 버튼을 한 번 더 누르면 종료됩니다.'),
              duration: Duration(seconds: 1),
            ),
          );
          bool =  false; // 앱을 종료하지 않음
        } else {
          bool = true; // 앱을 종료함
        }
        // 2초 내에 두 번째 클릭이 발생하면 앱 종료
        if(bool){
          controller.onClose();
          SystemNavigator.pop(); // 앱 종료
        }
      },
      child: Scaffold(
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
    ),
    );
  }
}
