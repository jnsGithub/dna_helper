import 'package:dna_helper/global.dart';
import 'package:dna_helper/view/login/loginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindPasswordView extends GetView<LoginController> {
  const FindPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 146,),
            Text('비밀번호 찾기', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
            const SizedBox(height: 50,),
            const Text('이메일 주소', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.6333,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: gray300),
                    borderRadius: BorderRadius.circular(6),
                    color: bgColor,
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      hintText: '이메일',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width:1.5, color: mainColor),
                        )
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size(size.width * 0.2590, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: mainColor,
                  ),
                  onPressed: (){

                  },
                  child: const Text('비밀번호 찾기'),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
