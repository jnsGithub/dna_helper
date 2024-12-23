import 'package:dna_helper/models/affiliation.dart';
import 'package:dna_helper/models/farm.dart';
import 'package:dna_helper/models/myInfo.dart';
import 'package:dna_helper/util/mainData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as url;

Color mainColor = const Color(0xff026DB5);
Color bgColor = const Color(0xffF7F7FA);
const font2020 = Color(0xff202020);
const font2424 = Color(0xff242424);
const font4343 = Color(0xff434343);
const font3030 = Color(0xff303030);
const font1A1A = Color(0xff1A1A1A);
const gray900 = Color(0xff1A1A1A);
const gray800 = Color(0xff4A4A4A);
const gray700 = Color(0xff4A4A4A);
const gray600 = Color(0xff636366);
const gray500 = Color(0xff848487);
const gray400 = Color(0xff8E8E93);
const gray300 = Color(0xffAEAEB2);
const gray100 = Color(0xffE5E5EA);
const gray200 = Color(0xffD4D4D4);

late MyInfo myInfo;
String userType = '채취자';
String uid = '';
List<Affiliation> affiliationList = [];
RxList<Farm> farmList = <Farm>[].obs;

Future<void> init() async {
  MainData defultInit = MainData();
  affiliationList = await defultInit.getAffiliationList();
  if(userType == '채취자'){
    farmList.value= await defultInit.getFarmList();
  }
}

Future<void> launchUrl(uri) async {
  Uri _url = Uri.parse(uri);
  if (!await url.launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

void saving(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible:false,
      builder: (BuildContext context) {
        return const AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            elevation: 0, // 그림자 효과 없애기
            content: Center(
              child: CircularProgressIndicator(color: Colors.white,),
            )
        );
      });
}