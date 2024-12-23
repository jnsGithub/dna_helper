import 'package:dna_helper/global.dart';
import 'package:dna_helper/view/mainView/home/homeController.dart';
import 'package:dna_helper/view/mainView/myPage/farmManagement/farmManagementController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FarmManagementView extends GetView<FarmManagementController> {
  const FarmManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => FarmManagementController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  const Text('농장명',style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w500,color:font3030
                  ),),
                  const SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xfff6f6fa),
                    ),
                    child: TextField(
                      controller: controller.farmNameController,
                      readOnly: false,
                      decoration: InputDecoration(
                        border: InputBorder.none, // 밑줄 없애기
                        contentPadding: EdgeInsets.symmetric(horizontal: 16), // TextField 내부의 패딩 적용
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width:1.5,color: mainColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text('주소',style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w500,color:font3030
                  ),),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Obx(()=>
                        Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                controller.kopoModel(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      width: size.width*0.6333,
                                      height: size.width*0.1282,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          color: const Color(0xfff6f6fa)),
                                      child: Text(controller.address.value == '' ? '우편번호를 검색하세요' : controller.address.value,style: TextStyle(
                                          fontSize: 15,
                                          color: controller.address.value == '' ? Color(0xffAEAEB2) : Colors.black
                                      ),)
                                  ),
                                  Container(
                                    width: size.width*0.2590,
                                    height: size.width*0.1282,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: mainColor,
                                    ),
                                    child: const Text('우편번호 검색',style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white
                                    ),),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 9,),
                            Container(
                              width: size.width,
                              height: size.width*0.1282,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xfff6f6fa)),
                              child: TextField(
                                controller: controller.addressDetailController,
                                focusNode: controller.addressFocus,
                                decoration: InputDecoration(
                                  hintText: '상세주소를 입력하세요 (ex. 101호 101호)',
                                  hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xffAEAEB2)
                                  ),
                                  border: InputBorder.none, // 밑줄 없애기
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16), // TextField 내부의 패딩 적용
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width:1.5,color: mainColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        minimumSize: Size(size.width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () async {
                        if(controller.farmNameController.text == ''){
                          Get.snackbar('농장명 입력', '농장명을 입력해주세요.', backgroundColor: Colors.white, colorText: Colors.black);
                          return;
                        }
                        else if(controller.address.value == ''){
                          Get.snackbar('주소 입력', '주소를 입력해주세요.', backgroundColor: Colors.white, colorText: Colors.black);
                          return;
                        }
                        await controller.addFarmInfo();
                        var controller2 = Get.find<HomeController>();
                        controller2.init();
                      },
                      child: Text('저장', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),)
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: size.width,
              height: 5,
              color: bgColor,
            ),
            Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: bgColor, width: 2),),
              ),
              child: Text('농장 목록',style: TextStyle(
                  fontSize: 19,fontWeight: FontWeight.w700,color: Colors.black
              ),),
            ),
            SafeArea(
              child: Obx(() => ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const Divider(
                    color: Color(0xffE1E1E1),
                    thickness: 1,
                  ),
                  shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: farmList.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(farmList[index].farmName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                GestureDetector(
                                  onTap: (){
                                    controller.deleteIndex(size, index);
                                  },
                                  child: Image(image: AssetImage('assets/images/delete.png'),width: 20,height: 20,),
                                )
                              ],
                            ),
                            SizedBox(height: 15,),
                            Container(
                              width: size.width * 0.7,
                                child: Text(
                                  farmList[index].farmAddress,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, height: 1.5),)),
                          ],
                        ),
                      );
                    }
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
