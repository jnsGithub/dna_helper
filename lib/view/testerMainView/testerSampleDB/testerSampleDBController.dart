import 'package:dna_helper/models/collect.dart';
import 'package:get/get.dart';

class TesterSampleDBController extends GetxController{
  RxInt selectedIndex = 0.obs;

  Rx<Collect?> collect = Rxn<Collect>();
  // RxBool isExist = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}