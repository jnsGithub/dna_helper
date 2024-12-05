import 'package:dna_helper/component/widget.dart';
import 'package:dna_helper/global.dart';
import 'package:dna_helper/view/mainView/home/homeController.dart';
import 'package:dna_helper/view/mainView/myPage/myPageView.dart';
import 'package:dna_helper/view/mainView/qrScan/qrScanView.dart';
import 'package:dna_helper/view/mainView/sampleDB/sampleDBView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    Size size = MediaQuery.of(context).size;
    return Obx(() => Scaffold(
        appBar: controller.selectIndex.value == 0 ? AppBar(
          toolbarHeight: 141,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          centerTitle: false,
          backgroundColor: mainColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.arrow_drop_down, color: Colors.white, size: 30,),
              Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.selectFarm(context, size);
                      },
                        child: Text(controller.farmName.value, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600))),
                    SizedBox(height: 10),
                    Container(
                      width: size.width * 0.7,
                      child: Text(controller.address.value,
                          maxLines: 2,
                          style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500, height: 1.5)),
                    )
                  ],
                ),
              )
            ],
          )
        ) : null,
        body: controller.selectIndex.value == 0 ? SampleDBView()
            : controller.selectIndex.value == 1? QrScanView() : MyPageView(),
        bottomNavigationBar: bottomNavi(context, controller.selectIndex, size),
      ),
    );
  }
}
