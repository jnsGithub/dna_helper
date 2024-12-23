import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dna_helper/global.dart';
import 'package:dna_helper/models/myInfo.dart';
import 'package:dna_helper/view/login/findPasswordView.dart';
import 'package:dna_helper/view/login/signUp/singUpView.dart';
import 'package:dna_helper/view/login/signUp/userTypeCheckView.dart';
import 'package:dna_helper/view/mainView/home/homeView.dart';
import 'package:dna_helper/view/mainView/myPage/allFarmingList/allFarmingListView.dart';
import 'package:dna_helper/view/mainView/myPage/farmManagement/farmManagementView.dart';
import 'package:dna_helper/view/testerMainView/testerHome/testerHomeView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';
import 'view/login/loginView.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

bool isLogin = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // var status = await Permission.manageExternalStorage.status;
  // var status2 = await Permission.storage.status;
  // if (!status.isGranted || !status2.isGranted) {
  //   await Permission.storage.request();
  //   await Permission.manageExternalStorage.request();
  // }
  // if(await Permission.manageExternalStorage.request().isGranted && await Permission.storage.request().isGranted)
  // {
  //   print('엑셀 다운로드 권한 허용');
  // } else {
  //   print('엑셀 다운로드 권한 거부');
  // }
  //
  // print('storage permission granted: ${await Permission.storage.isGranted}');
  // print('manageExternalStorage permission granted: ${await Permission.manageExternalStorage.isGranted}');

  isLogin = auth.FirebaseAuth.instance.currentUser != null;
  if(isLogin){
    final db = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await db.collection('users').doc(auth.FirebaseAuth.instance.currentUser!.uid).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    data['documentId'] = snapshot.id;
    myInfo = MyInfo.fromMap(data);
    await init();

  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('ko', 'KR'),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: false,
          fontFamily: 'Pretendard',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              backgroundColor:  Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400
              ), elevation:0
          )
      ),
      initialRoute: !isLogin ? '/loginView' : myInfo.userType == '채취자' ? '/homeView' : '/testerHomeView',
      getPages: [
        GetPage(name: '/loginView', page: () => const LoginView()),
        GetPage(name: '/userTypeCheckView', page: () => const UserTypeCheckView()),
        GetPage(name: '/signUpView', page: () => const SignUpView()),
        GetPage(name: '/findPasswordView', page: () => FindPasswordView()),
        GetPage(name: '/homeView', page: () => const HomeView()),
        GetPage(name: '/testerHomeView', page: () => const TesterHomeView()),
        GetPage(name: '/farmManagementView', page: () => const FarmManagementView()),
        GetPage(name: '/allFarmingListView', page: () => AllFarmingListView()),
      ],
    );
  }
}
