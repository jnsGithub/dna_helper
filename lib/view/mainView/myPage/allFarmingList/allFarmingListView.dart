import 'package:dna_helper/global.dart';
import 'package:dna_helper/view/mainView/myPage/allFarmingList/allFarmginListController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AllFarmingListView extends GetView<AllFarmingListController> {
  const AllFarmingListView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => AllFarmingListController());
    double dateWidth = size.width*0.25;
    double addressWidth = size.width*0.4;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("'${myInfo.name}'님의 전체 채취 이력",style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  top: BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      width: dateWidth,
                      child: Text('채취일자',style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),),
                    ),
                    Container(
                      width: addressWidth,
                      child: Text('주소',style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),),
                    ),
                  ],
                ),
              ),
            ),
            Obx(() => ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 90),
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.farmingList.length,
                  itemBuilder: (context, index) {
                  return Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF4F4FA),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: dateWidth,
                                child: Text('${controller.farmingList[index].createdAt.year}.${controller.farmingList[index].createdAt.month}.${controller.farmingList[index].createdAt.day}',style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),),
                              ),
                              Container(
                                width: addressWidth,
                                child: Text(controller.farmingList[index].farmAddress,style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),),
                              ),
                            ],
                          ),
                          SizedBox(height: 18,),
                          Container(
                            width: size.width,
                            height: 70,
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: Color(0xffF4F4FA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(controller.farmingList[index].farmName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                SizedBox(height: 10,),
                                Text('개체 식별 번호 : ${controller.farmingList[index].identification}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
              }),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        width: size.width,
        height: 85,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
              onPressed: () async {
              saving(context);
              print(123);
              var status = await Permission.storage.status;
              var manageStatus = await Permission.manageExternalStorage.status;
              if (!status.isGranted || !manageStatus.isGranted) {
                await Permission.storage.request();
                await Permission.manageExternalStorage.request();
              }

              await Permission.storage.request();
              await controller.transExcelFile();
              Get.back();
              print('엑셀 다운로드');
              },
              child: Text('엑셀 다운로드', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
        )
      ),
    );
  }
}
