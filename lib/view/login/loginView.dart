import 'package:dna_helper/component/widget.dart';
import 'package:dna_helper/global.dart';
import 'package:dna_helper/models/myInfo.dart';
import 'package:dna_helper/util/addQR.dart';
import 'package:dna_helper/util/qrCheck.dart';
import 'package:dna_helper/view/login/loginController.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/images/logo.png'), width: 200, height: 200,),
              const SizedBox(height: 20),
              const Text('가축 DNA 채취 도우미', style: TextStyle(fontSize: 21, color: Colors.white, fontFamily: 'GmarketSans', fontWeight: FontWeight.w700),),
              const SizedBox(height: 34),
              TextFieldWidget(context, '이메일', size.width, Colors.white, mainColor, controller.emailController, textColor: Colors.white),
              const SizedBox(height: 25),
              TextFieldWidget(context, '비밀번호', size.width, Colors.white, mainColor, controller.passwordController, isObscure: true, textColor: Colors.white),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () async {
                        Get.toNamed('/userTypeCheckView');
                      },
                      child: const Text('회원가입', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                      )
                  ),
                  const Text('  /  ', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)
                  ),
                  GestureDetector(
                      onTap: () async {
                        Get.toNamed('/findPasswordView');
                      },
                      child: const Text('비밀번호 찾기', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                      )
                  ),
                ],
              ),
              const SizedBox(height: 29,),
              ElevatedButton(
                onPressed: () {
                  myInfo = MyInfo(documentId: '1', name: '김밥', userType: '채취자', selectedFarm: 'selectedFarm', affiliation: 'affiliation');
                  Get.offAllNamed('/homeView');
                  // Get.offAllNamed('/testerHomeView');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(size.width, 50),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text('로그인', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),),
              ),
              TextButton(
                  onPressed: () async {
                    saving(context);
                    try{
                      QrCodeUploader a = QrCodeUploader();
                      QRCheck b = QRCheck();
                      // a.generateAndUploadQRCode(10);
                      b.checkQR('IRRY8ozO0tG3vssyjJRY');
                      Get.back();
                    }catch(e){
                      print(e);
                    }
                  }, child: Text('TextButton', style: TextStyle(color: Colors.yellow),))
            ],
          ),
        ),
      ),
    );
  }
}
