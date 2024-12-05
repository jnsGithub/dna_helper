import 'package:dna_helper/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';





class UserTypeCheckView extends StatelessWidget {
  const UserTypeCheckView ({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 178),
            const Text('회원선택',style: TextStyle(
                fontSize: 24,fontWeight: FontWeight.w600
            ),),
            const SizedBox(height: 20),
            const Text('회원 유형을 선택해 주세요',style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    userType = '실험자';
                    Get.toNamed('/signUpView', arguments: userType);
                  },
                  child: Container(
                    width: size.width*0.44,
                    height: size.width*0.51,
                    padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xffF7F7FA),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(image: AssetImage('assets/images/labs.png'),width: 35,color: Color(0xffFB2525),),
                        SizedBox(height: 22),
                        Text('실험자 회원',style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: gray700
                        ),),
                        SizedBox(height: 22),
                        Text('실험자가 가입할 수 있으며\n별도의 승인이 필요해요',style: TextStyle(
                            fontSize: 13,fontWeight: FontWeight.w400,color: gray800
                        ),)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    userType = '채취자';
                    Get.toNamed('/signUpView', arguments: userType);
                  },
                  child: Container(
                    width: size.width*0.44,
                    height: size.width*0.51,
                    padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xffF7F7FA),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(image: const AssetImage('assets/images/genetics.png'),width: 35,color: mainColor,),
                        const SizedBox(height: 22),
                        const Text('채취자 회원',style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: gray700
                        ),),
                        const SizedBox(height: 22),
                        const Text('채취자가 가입할 수 있으며\n별도의 승인이 필요없어요',style: TextStyle(
                            fontSize: 13,fontWeight: FontWeight.w400,color: gray600
                        ),)
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
