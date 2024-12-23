import 'package:dna_helper/models/collect.dart';
import 'package:dna_helper/util/mainData.dart';
import 'package:dna_helper/util/transExcel.dart';
import 'package:get/get.dart';

class AllFarmingListController extends GetxController {
  String name = '이름';

  RxList<Collect> farmingList = <Collect>[].obs;

  TransExcel transExcel = TransExcel();

  MainData mainData = MainData();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onClose() {
    super.onClose();
  }

  init() async {
    await getFarmingList();
  }

  transExcelFile() async {
    await transExcel.toExcel(farmingList);
  }

  getFarmingList() async{
    farmingList.value = await mainData.getMyCollection();
  }
}