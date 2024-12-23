import 'package:dna_helper/global.dart';
import 'package:dna_helper/view/mainView/myPage/myPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPageView extends GetView<MyPageController> {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MyPageController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                Text('마이페이지',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                SizedBox(height: 30,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(myInfo.name,style: TextStyle(fontSize: 18, color: gray900, fontWeight: FontWeight.w500),),
                    SizedBox(height: 16,),
                    Text(myInfo.email,style: TextStyle(fontSize: 16, color:gray700, fontWeight: FontWeight.w500),),
                  ],
                ),
                SizedBox(height: 30,),
                myInfo.userType == '채취자' ? GestureDetector(
                  onTap: (){
                    Get.toNamed('/farmManagementView');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: gray100)
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('농장 관리',style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.w500),),
                        Icon(Icons.navigate_next,color:gray200,)
                      ],
                    ),
                  ),
                ) : SizedBox(),
                myInfo.userType == '채취자' ? GestureDetector(
                  onTap: (){
                    Get.toNamed('/allFarmingListView');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: gray100)
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('전체 채취 이력',style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.w500),),
                        Icon(Icons.navigate_next,color:gray200,)
                      ],
                    ),
                  ),
                ) : SizedBox(),
                GestureDetector(
                  onTap: (){
                    controller.selectLabs(context, size);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: gray100)
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('소속 기관 변경',style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.w500),),
                        Icon(Icons.navigate_next,color:gray200,)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    launchUrl('https://learned-print-ace.notion.site/160a262ebf2580c88206d7c753c1266b?pvs=4');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: gray100)
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('서비스 이용 약관',style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.w500),),
                        Icon(Icons.navigate_next,color:gray200,)
                      ],
                    ),
                  ),
                ),GestureDetector(
                  onTap: (){
                    launchUrl('https://learned-print-ace.notion.site/160a262ebf258043a2fcc8c31f78a5fd?pvs=4');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: gray100)
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('개인정보처리방침',style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.w500),),
                        Icon(Icons.navigate_next,color:gray200,)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await controller.signOut();
                    farmList.clear();
                    Get.offAllNamed('/loginView');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: gray100)
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('로그아웃',style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.w500),),
                        Icon(Icons.navigate_next,color:gray200,)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    controller.deleteAccount(size);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: gray100)
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('회원탈퇴',style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.w500),),
                        Icon(Icons.navigate_next,color:gray200,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
