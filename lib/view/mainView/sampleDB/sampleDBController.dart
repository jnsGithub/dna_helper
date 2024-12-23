import 'package:dna_helper/global.dart';
import 'package:dna_helper/models/collect.dart';
import 'package:dna_helper/util/qrCode.dart';
import 'package:dna_helper/util/transExcel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SampleDBController extends GetxController {
  List<int> data = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<TextEditingController>  textController = [];

  RxList<Collect> collectList = <Collect>[].obs;

  QrCode qr = QrCode();

  @override
  void onInit() {
    init();
    super.onInit();
    for(int i = 0; i < collectList.length; i++){
      textController.add(TextEditingController());
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  init() async {
    await getTempQrCode();
  }

  addCollect(Collect collect) async {
    for(int i = 0; i < collectList.length; i++){
      if(collectList[i].documentId == collect.documentId){
        if(!Get.isSnackbarOpen){
          Get.snackbar('알림', '이미 등록된 개체입니다.');
        }
        return;
      }
    }
    collectList.insert(0, collect);
    textController.insert(0, TextEditingController());
    print(collectList.length);
  }

  setTempQrCode() async {
    await qr.tempSave(collectList);
  }

  getTempQrCode() async {
    collectList.clear();
    List<Collect> list = await qr.getTempQrCode();
    for(int i = 0; i < list.length; i++){
      collectList.add(list[i]);
      textController.add(TextEditingController());
      textController[i].text = list[i].identification;
    }
  }

  deleteIndex(size, index) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actionsPadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.only(top: 50, bottom: 30),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('해당 개체를 삭제하시겠습니까?', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, color: font3030
              ),),
              // SizedBox(height: 10),
              // Text(
              //   '거절 시, 해당 콜 배정이 안됩니다', style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w600, color: mainColor
              // ),),
            ],
          ),
          actions: [
            Container(
              width: size.width,
              height: 48.1,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xffe0e0e0),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 48.1,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Color(0xffe0e0e0),
                              width: 1,
                            ),
                          ),
                        ),
                        child: const Text(
                          '취소',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff303030),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // qr.tempDelete(collectList[index].documentId);
                        collectList.removeAt(index);
                        textController.removeAt(index);
                        Get.back();
                      },
                      child: Container(
                        height: 48.1,
                        alignment: Alignment.center,
                        child: const Text(
                          '확인',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffFF0000),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  sendOrDownload(size) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.only(top: 30, bottom: 30),
          actionsPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('샘플 채취이력을 저장 및\n관리자에게 전송하시겠습니까?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 18,
                  fontWeight: FontWeight.w600, color: font3030,
              ),),
              SizedBox(height: 10),
              Text(
                '(전송한 DB는 마이페이지 >\n전체 채취 이력에서 확인 가능합니다.)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 16,
                  fontWeight: FontWeight.w600, color: gray800
              ),),
            ],
          ),
          actions: [
            Container(
              width: size.width,
              height: 48.1,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xffe0e0e0),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 48.1,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Color(0xffe0e0e0),
                              width: 1,
                            ),
                          ),
                        ),
                        child: const Text(
                          '취소',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff303030),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        Get.back();
                        saving(context);
                        for(int i = 0; i < collectList.length; i++){
                          await qr.tempDelete(collectList[i].documentId);
                        }
                        await qr.qrCodeSetting(collectList);
                        // if(collectList.length != 0){
                        //   await TransExcel().toExcel(collectList);
                        //   Get.back();
                        // }
                        collectList.clear();
                        textController.clear();
                      },
                      child: Container(
                        height: 48.1,
                        alignment: Alignment.center,
                        child: const Text(
                          '확인',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffFF0000),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}