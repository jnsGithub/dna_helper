import 'package:dna_helper/global.dart';
import 'package:dna_helper/view/testerMainView/testerHome/testerHomeController.dart';
import 'package:dna_helper/view/testerMainView/testerSampleDB/testerSampleDBController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TesterSampleDBView extends GetView<TesterSampleDBController> {
  const TesterSampleDBView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TesterSampleDBController());
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: (size.height * 0.0355)),
      child: Obx(() => Column(
          children: [
            Container(
                width: size.width,
                height: controller.collect.value != null ? size.height * 0.0711 : size.height * 0.0972,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: controller.collect.value != null ? 15 : 21),
                decoration: BoxDecoration(
                  color: controller.collect.value != null ? Color(0xffFCBDBD).withOpacity(0.3) : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: controller.collect.value != null ? Colors.transparent : Color(0xffFCBDBD)),
                ),
                child: controller.collect.value != null ? Text('샘플 정보', style: TextStyle(fontSize: 22, color: mainColor, fontWeight: FontWeight.w600),) : Text.rich(
                  maxLines: 2,
                  TextSpan(
                    text: '샘플에 부착된 QR코드를 스캔해주세요.\n',
                    style: TextStyle(fontSize: 15, color: mainColor),
                    children: [
                      TextSpan(
                        text: '해당 개체에 맞는 정보',
                        style: TextStyle(fontSize: 15, color: mainColor, fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: '들을 알 수 있어요.',
                        style: TextStyle(fontSize: 15, color: mainColor),
                      ),
                    ],
                  ),
                )
            ),
            SizedBox(height: size.height * 0.0277),
            Obx(()=>
            controller.collect.value != null
                ? Container(
              width: size.width,
              height: size.height * 0.4882,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffF4F4FA)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('개체 식별 번호 : ${controller.collect.value!.identification}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, height: 2),),
                  Text('채취자 : ${controller.collect.value!.scannerName}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, height: 2),),
                  Text('채취일자 : ${controller.collect.value!.createdAt.year}.${controller.collect.value!.createdAt.month}.${controller.collect.value!.createdAt.day}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, height: 2),),
                  Text('농장명 : ${controller.collect.value!.farmName}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, height: 2),),
                  Text('주소 : ${controller.collect.value!.farmAddress}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, height: 2),),

                ],
              ),
            )
                : GestureDetector(
              onTap: (){
                var controller = Get.find<TesterHomeController>();
                controller.selectedIndex.value = 1;
              },
                  child: Container(
                              width: size.width,
                              height: size.height * 0.5687,
                              decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffF4F4FA)
                              ),
                              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.qr_code_scanner, size: 54, color: mainColor,),
                    SizedBox(height: 10),
                    Text('DNA 샘플 Qr코드를 인식해주세요.', style: TextStyle(fontSize: 20, color: gray600, fontWeight: FontWeight.w400),),
                  ],
                              ),
                            ),
                )),
            controller.collect.value != null ? SizedBox(height: 10) : SizedBox(),
            controller.collect.value != null ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                minimumSize: Size(size.width, 50),
              ),
                onPressed: (){
                  controller.collect.value = null;
                  var controller2 = Get.find<TesterHomeController>();
                  controller2.selectedIndex.value = 1;

            },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh, color: Colors.white,),
                    SizedBox(width: 10,),
                    Text('다시 스캔', style: TextStyle(fontSize: 20, color: Colors.white),),
                  ],
                )
            ) : SizedBox(),
          ],
        ),
      ),
    );
  }
}
