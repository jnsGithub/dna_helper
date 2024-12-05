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
import 'firebase_options.dart';
import 'view/login/loginView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      initialRoute: '/loginView',
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
