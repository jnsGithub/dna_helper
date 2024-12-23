import 'package:dna_helper/global.dart';
import 'package:dna_helper/models/affiliation.dart';
import 'package:dna_helper/util/mainData.dart';
import 'package:dna_helper/util/sign.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPageController extends GetxController {
  RxInt selectLabsIndex = 0.obs;

  Sign sign = Sign();
  MainData affiliation = MainData();

  @override
  void onInit() {
    super.onInit();
    for(int i = 0; i < affiliationList.length; i++){
      if(affiliationList[i].affiliation == myInfo.affiliation){
        selectLabsIndex.value = i;
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  signOut() async {
    await sign.signOut();
  }

  deleteAccount(size) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.only(top: 50, bottom: 30),
          actionsPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('회원 탈퇴 하시겠습니까?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 18,
                  fontWeight: FontWeight.w600, color: font3030,
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

  selectLabs(BuildContext context, size) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 37),
          child: SizedBox(
            height: 370,
            child: ListView.builder(
              itemCount: affiliationList.length,
              itemBuilder: (context, index) {
                return Obx(() => Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        myInfo.affiliation = affiliationList[index].affiliation;
                        for(int i = 0; i < affiliationList.length; i++){
                          if(affiliationList[i].affiliation == myInfo.affiliation){
                            selectLabsIndex.value = i;
                          }
                        }
                        affiliation.updateAffiliation(affiliationList[index].affiliation);
                        // Get.back();
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
                                  image: selectLabsIndex.value == index
                                      ? AssetImage('assets/images/check.png')
                                      : AssetImage(
                                      'assets/images/noncheck.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // child: Icon(Icons.check, color: selected.value == index ? Colors.white : gray300, size: 20,),
                            ),
                            SizedBox(width: 20,),
                            Text(affiliationList[index].affiliation, style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600),),
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
}