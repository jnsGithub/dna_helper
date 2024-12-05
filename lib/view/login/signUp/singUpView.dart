import 'package:dna_helper/component/widget.dart';
import 'package:dna_helper/global.dart';
import 'package:dna_helper/models/myInfo.dart';
import 'package:dna_helper/view/login/signUp/signUpController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SignUpController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('${userType} 회원가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('회원가입을 위해 아래 사항을 입력해주세요', style: TextStyle(fontSize: 14, color: gray600, fontWeight: FontWeight.w400),),
              const SizedBox(height: 28),
              TextFieldWidget(context, '이메일', size.width, bgColor, mainColor, controller.emailController),
              const SizedBox(height: 25),
              TextFieldWidget(context, '이름', size.width, bgColor, mainColor, controller.nameController),
              const SizedBox(height: 25),
              TextFieldWidget(context, '비밀번호', size.width, bgColor, mainColor, controller.passwordController,),
              const SizedBox(height: 25),
              TextFieldWidget(context, '비밀번호 확인', size.width, bgColor, mainColor, controller.passwordCheckController,),
              const SizedBox(height: 25),
              Text('소속 기관', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),),
              const SizedBox(height: 9,),
              GestureDetector(
                onTap: (){
                  controller.bottomSheet(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(controller.group.value, style: TextStyle(fontSize: 14),)),
                      Icon(Icons.arrow_drop_down)
                    ],
                  )
                ),
              ),
              const SizedBox(height: 25),
              Text('약관동의', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),),
              const SizedBox(height: 9,),
              Obx(()=>
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            splashRadius: 1,
                            activeColor: mainColor,
                            value: controller.isCheck.value,
                            onChanged: (value) {
                              controller.changeBox(1);
                            },
                          ),
                          const Text("서비스 이용 약관 동의",style: TextStyle(fontSize: 12, color: Color(0xff313740), fontWeight: FontWeight.w500),),
                          const Text(" (필수)",style: TextStyle(fontSize: 12, color: Color(0xffE30E0E)),),
                        ],
                      ),
                      IconButton(onPressed: (){
                        // launchUrl('https://electric-fortnight-2a5.notion.site/Hero-7c69686297ee4ab287c7bd6e83864584?pvs=4');
                      }, icon: const Icon(Icons.navigate_next))
                    ],
                  ),
              ),
              Obx(()=>
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            splashRadius: 1,
                            activeColor: mainColor,
                            value: controller.isCheck2.value,
                            onChanged: (value) {
                              controller.changeBox(2);
                            },
                          ),
                          const Text("개인정보수집 및 이용 동의",style: TextStyle(fontSize: 12, color: Color(0xff313740), fontWeight: FontWeight.w500),),
                          const Text(" (필수)",style: TextStyle(fontSize: 12, color: Color(0xffE30E0E)),),
                        ],
                      ),
                      IconButton(onPressed: (){
                        // launchUrl('https://electric-fortnight-2a5.notion.site/Hero-7c69686297ee4ab287c7bd6e83864584?pvs=4');
                      }, icon: const Icon(Icons.navigate_next))
                    ],
                  ),
              ),
              SizedBox(height: 30),
              Obx(() => SafeArea(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(size.width, 50),
                        backgroundColor: controller.isComplete.value ? mainColor : Color(0xffF7F7FA),
                        side: BorderSide(color: gray100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () async {
                        if(!controller.isValidEmail(controller.emailController.text)){
                          if(!Get.isSnackbarOpen){
                            Get.snackbar('알림', '이메일 양식을 확인해주세요.');
                          }
                          return;
                        }
                        if(controller.isComplete.value){
                          saving(context);
                          if(await controller.signUp()){
                            Get.offAllNamed('/homeView');
                          }
                          else {
                            Get.offAllNamed('/loginView');
                            Get.snackbar('알림', '관리자 승인이 완료되면 로그인이 가능합니다.');
                          }
                        }
                      },
                      child: Text('가입하기', style: TextStyle(fontSize: 16, color: controller.isComplete.value ? Colors.white : Colors.black, fontWeight: FontWeight.w500),),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
