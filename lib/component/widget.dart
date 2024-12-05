import 'package:dna_helper/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget TextFieldWidget(BuildContext context, String title, double size, Color bgColor, Color mainColor, TextEditingController controller, {Color? textColor, double? heith, int? maxLines, bool? isObscure}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontSize: 15, color: textColor ?? Colors.black, fontWeight: FontWeight.w500),),
      const SizedBox(height: 9,),
      Container(
        width: size,
        height: heith ?? 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: bgColor
        ),
        child: TextField(
          controller: controller,
          maxLines: maxLines ?? 1,
          obscureText: isObscure ?? false,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusColor: mainColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width:1.5,color: mainColor),
              )
          ),
        ),
      ),
    ],
  );
}

Widget bottomNavi(BuildContext context, RxInt selectIndex, Size size) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
    height: 80,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            selectIndex.value = 0;
          },
          child: Container(
            width: size.width * 0.25,
            height: 86,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
            ),
            child: Obx(() => ElevatedButton(
              onPressed: () {
                selectIndex.value = 0;
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                backgroundColor: Colors.white,
              ),
              child: Column(
                children: [
                  Icon(Icons.home_filled, color: selectIndex.value == 0 ? mainColor : gray500,),
                  const SizedBox(height: 5,),
                  Text('채취 DB', style: TextStyle(color: selectIndex.value == 0 ? mainColor : gray500, fontSize: 12, fontWeight: FontWeight.w500,),),
                ],
              ),
            )),
          ),
        ),
        GestureDetector(
          onTap: () {
            selectIndex.value = 1;
          },
          child: Container(
            width: size.width * 0.25,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
            ),
            child: Obx(() => ElevatedButton(
              onPressed: () {
                selectIndex.value = 1;
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                backgroundColor: Colors.white,
              ),
              child: Column(
                children: [
                  Icon(Icons.qr_code_scanner, color: selectIndex.value == 1 ? mainColor : gray500,),
                  const SizedBox(height: 5,),
                  Text('QR스캔', style: TextStyle(color: selectIndex.value == 1 ? mainColor : gray500, fontSize: 12, fontWeight: FontWeight.w500,),),
                ],
              ),
            )),
          ),
        ),
        GestureDetector(
            onTap: () {
              selectIndex.value = 2;
            },
            child: Container(
              width: size.width * 0.25,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
              ),
              child: Obx(() => ElevatedButton(
                onPressed: () {
                  selectIndex.value = 2;
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: Colors.white,),
                child: Column(
                  children: [
                    Icon(Icons.person, color: selectIndex.value == 2 ? mainColor : gray500,),
                    const SizedBox(height: 5,),
                    Text('마이페이지', style: TextStyle(color: selectIndex.value == 2 ? mainColor : gray500, fontSize: 12, fontWeight: FontWeight.w500,),),
                  ],
                ),
              ),
              ),
            )
        )
      ],
    ),
  );
}