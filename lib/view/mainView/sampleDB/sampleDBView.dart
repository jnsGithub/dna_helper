import 'package:dna_helper/global.dart';
import 'package:dna_helper/view/mainView/sampleDB/sampleDBController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SampleDBView extends GetView<SampleDBController> {
  const SampleDBView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SampleDBController());
    Size size = MediaQuery.of(context).size;
    double dateWidth = 80;
    double classWidth = 35;
    double numberWidth = 110;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('QR 스캔 샘플 정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      maximumSize: Size(size.width*0.1538, 30),
                      minimumSize: Size(size.width*0.1538, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: (){

                    },
                    child: Text('저장')
                ),
              ],
            ),
          ),
          Container(
            width: size.width,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.symmetric(horizontal: BorderSide(color: Colors.black, width: 1)),
            ),
            child: Row(
              children: [
                Container(
                  width: dateWidth,
                  child: Text('채취 일자', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                ),
                SizedBox(width: 34,),
                Container(
                  width: classWidth,
                  child: Text('개체', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                ),
                Container(
                  width: numberWidth,
                  child: Text('식별 번호', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                ),
              ],
            ),
          ),
          Container(
            height: size.height * 0.45,
            child: Obx(() => ListView.separated(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.collectList.length,
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Color(0xffE5E5EA),
                      height: 1,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      width: size.width,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: dateWidth,
                                child: Text('2024.11.25', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                              ),
                              SizedBox(width: 34,),
                              Container(
                                width: classWidth,
                                child: Text('002', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                              ),
                              Container(
                                width: numberWidth,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: TextField(
                                  controller: controller.textController[index],
                                  onChanged: (value) {
                                    controller.collectList[index].identification = value;
                                    print(controller.collectList[index].identification);
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(left: 10, bottom: 17),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1.5, color: mainColor),
                                    ),
                                  ),
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(size.width*0.1462, 30),
                                maximumSize: Size(size.width*0.1462, 30),
                                backgroundColor: Color(0xffFB2525),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () {
                                controller.deleteIndex(size, index);
                              },
                              child: Text('삭제', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),))
                        ],
                      ),
                    );
                  }
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(size.width, 50),
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: (){
                  controller.sendOrDownload(size);
                },
                child: Text('전송 및 액셀 다운로드', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),)),
          )

        ],
      ),
    );
  }
}