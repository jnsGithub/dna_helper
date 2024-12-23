import 'package:dna_helper/global.dart';
import 'package:dna_helper/util/mainData.dart';
import 'package:dna_helper/util/sign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Sign sign = Sign();

  RxInt selected = (-1).obs;

  RxBool isComplete = false.obs;

  RxBool isCheck = false.obs;
  RxBool isCheck2 = false.obs;

  RxString group = ''.obs;

  MainData mainData = MainData();

  List<String> groupList = ['제이제이 실험기관', '실험 기관명 1', '실험 기관명 2', '실험 기관명 2', '실험 기관명 3', '실험 기관명 4', '실험 기관명 5', '실험 기관명 6', '실험 기관명 7', '실험 기관명 8'];
  @override
  void onInit() {
    super.onInit();
    userType = Get.arguments;
    init();
    emailController.addListener(_validateForm);
    nameController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
    passwordCheckController.addListener(_validateForm);
    group.listen((_) => _validateForm());
    isCheck.listen((_) => _validateForm());
    isCheck2.listen((_) => _validateForm());
  }

  @override
  void onClose() {
    super.onClose();
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordCheckController.dispose();
    nameController.dispose();
    userType = '';
    group.value = '';
    print(1);
    super.dispose();
  }

  init() async{
    affiliationList = await mainData.getAffiliationList();
  }

  signUp() async {
     return await sign.signUp(emailController.text, passwordController.text, nameController.text, group.value);
  }

  bool isValidEmail(String email) {
    // 정규식으로 이메일 형식 검증
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    print(emailRegex.hasMatch(email));
    return emailRegex.hasMatch(email);
  }

  void _validateForm() {
    if (emailController.text != ''
        && passwordController.text != ''
        && passwordCheckController.text != ''
        && isCheck.value == true
        && isCheck2.value == true
        && nameController.text != ''
        && group.value != ''
        && passwordController.text == passwordCheckController.text
        && passwordController.text.length >= 6) {
      isComplete.value = true;
    } else {
      isComplete.value = false;
    }
  }

  changeBox(index){
    if(index == 1 ){
      isCheck.value = !isCheck.value;
    } else if(index == 2) {
      isCheck2.value = !isCheck2.value;
    }
  }

  bottomSheet(context){
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
              itemBuilder: (context, index){
                return Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        selected.value = index;
                        group.value = affiliationList[index].affiliation;
                        Get.back();
                      },
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
                                image: selected.value == index ? AssetImage('assets/images/check.png') : AssetImage('assets/images/noncheck.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            // child: Icon(Icons.check, color: selected.value == index ? Colors.white : gray300, size: 20,),
                          ),
                          SizedBox(width: 20,),
                          Text(affiliationList[index].affiliation, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ),
                    SizedBox(height: 31,),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}