import 'package:dna_helper/global.dart';
import 'package:dna_helper/util/mainData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpostal/kpostal.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

class FarmManagementController extends GetxController {
  TextEditingController addressController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();
  TextEditingController farmNameController = TextEditingController();

  MainData mainData = MainData();

  FocusNode addressFocus = FocusNode();
  RxString address = ''.obs;

  Future kopoModel (context) async {
    // KopoModel? model = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => RemediKopo(),
    //   ),
    // );
    Kpostal model = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => KpostalView()
        )
    );
    if(model != null){
        address.value = model.address!;
        // startingPostcode.value = model.zonecode!;
        // FocusScope.of(Get.context!).requestFocus(startAddressDetail);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onClose() {
    super.onClose();
  }

  addFarmInfo() async {
    mainData.addFarm(farmNameController.text, (address.value + ' ' + addressDetailController.text));
    farmNameController.clear();
    addressDetailController.clear();
    address.value = '';
    await init();
  }

  deleteIndex(Size size, int index) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.only(top: 40, bottom: 30),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('해당 농장 정보를\n목록에서 삭제하시겠습니까?',
                textAlign: TextAlign.center,
                style: TextStyle(
                height: 1.5,
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
                      onTap: () async {
                        await mainData.deleteFarm(farmList[index].documentId, farmList[index].farmName, farmList[index].farmAddress);
                        // farmList.removeAt(index);
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
}