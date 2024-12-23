import 'package:dna_helper/global.dart';
import 'package:dna_helper/models/farm.dart';
import 'package:dna_helper/util/mainData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  RxInt selectIndex = 0.obs;
  RxInt selectFarmIndex = 0.obs;

  RxString farmName = ''.obs;
  RxString address = ''.obs;

  List<int> data = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<TextEditingController>  textController = [];

  MainData defaultInit = MainData();

  @override
  void onInit() {
    super.onInit();
    init();

  }
  @override
  void onClose(){
    super.onClose();
  }

  init() async {
    if(farmList.length == 0){
      farmName.value = '';
      address.value = '';
    }
    for(int i = 0; i < farmList.length; i++){
      if(farmList[i].farmName == myInfo.selectedFarmName){
        selectFarmIndex.value = i;
        farmName.value = farmList[i].farmName;
        address.value = farmList[i].farmAddress;
        myInfo.selectedFarmAddress = farmList[i].farmAddress;
        myInfo.selectedFarmName = farmList[i].farmName;
        print(farmList[i].farmName);
        print(farmList[i].farmAddress);
      }
      // farmName.value = myInfo.selectedFarmAddress!;
      // address.value = myInfo.selectedFarmName!;
    }
  }

  selectFarm(BuildContext context, size) {
      showModalBottomSheet(
        context: context,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(20))),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 37),
            child: SizedBox(
              height: 370,
              child: ListView.builder(
                itemCount: farmList.length,
                itemBuilder: (context, index) {
                  return Obx(() => Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectFarmIndex.value = index;

                            farmName.value = farmList[index].farmName;
                            address.value = farmList[index].farmAddress;
                            myInfo.selectedFarmName = farmList[index].farmName;
                            myInfo.selectedFarmAddress = farmList[index].farmAddress;
                            // Get.back();
                            for(int i = 0; i < farmList.length; i++){
                              if(farmList[i].farmName == myInfo.selectedFarmName){
                                selectFarmIndex.value = i;
                              }
                            }
                            defaultInit.updateFarm(myInfo.documentId, myInfo.selectedFarmName!, myInfo.selectedFarmAddress!);
                          },
                          child: Container(
                            width: size.width,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(1),
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    image: DecorationImage(
                                      image: selectFarmIndex.value == index
                                          ? AssetImage('assets/images/check.png')
                                          : AssetImage(
                                          'assets/images/noncheck.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // child: Icon(Icons.check, color: selected.value == index ? Colors.white : gray300, size: 20,),
                                ),
                                SizedBox(width: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(farmList[index].farmName, style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),),
                                    SizedBox(height: 5,),
                                    Container(
                                      width: size.width * 0.7,
                                      child: Text(farmList[index].farmAddress,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 31,),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    }

  Future<bool> exitApproved(BuildContext context, size) async {
    bool a = false;
    await showDialog(
      context: Get.context!,
      builder: (context) {
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
              Text('앱을 종료하시겠습니까?\n(저장하지 않은 샘플은 삭제됩니다.)', textAlign: TextAlign.center, style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, color: font3030
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
                      onTap: () {
                        a =  true;
                        Get.back();
                        // SystemNavigator.pop();
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
    return a;
  }
}