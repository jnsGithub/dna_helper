import 'package:dna_helper/global.dart';
import 'package:dna_helper/models/farm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  RxInt selectIndex = 0.obs;
  RxInt selectFarmIndex = 0.obs;

  RxString farmName = ''.obs;
  RxString address = ''.obs;

  List<int> data = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<TextEditingController>  textController = [];

  List<Farm> farm = [
    Farm(
        documentId: '1',
        farmName: '농장명 ( 농장 이름1)',
        address: '농장주소가 들어갑니다.'),
    Farm(
        documentId: '2',
        farmName: '제이엔에스농장',
        address: '서울특별시 영등포구 선유로 70 6층 609호 주소가 최대 두줄 까지 들어갈 수 있습니다.'),
    Farm(
        documentId: '3',
        farmName: '제이제이농장',
        address: '서울특별시 영등포구 선유로 70 6층 609호'),
    Farm(
        documentId: '4',
        farmName: '에스에스농장',
        address: '경상남도 창녕군 이방면 성산리 272'),
    Farm(
        documentId: '5',
        farmName: '제이제이농장',
        address: '강원특별자치도 인제군 상남면 미산리 산1'),

  ];

  @override
  void onInit() {
    super.onInit();
    farmName.value = farm[0].farmName;
    address.value = farm[0].address;
  }
  @override
  void onClose(){
    super.onClose();
  }

  selectFarm(BuildContext context, size) {
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
                itemCount: farm.length,
                itemBuilder: (context, index) {
                  return Obx(() => Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectFarmIndex.value = index;
                            farmName.value = farm[index].farmName;
                            address.value = farm[index].address;
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
                                    Text(farm[index].farmName, style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),),
                                    SizedBox(height: 5,),
                                    Container(
                                      width: size.width * 0.7,
                                      child: Text(farm[index].address,
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
  }