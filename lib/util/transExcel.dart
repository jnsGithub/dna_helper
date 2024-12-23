import 'package:dna_helper/global.dart';
import 'package:dna_helper/models/collect.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart' as ul;
import 'dart:async';


class TransExcel {
  late Excel excel;
  late Sheet sheet;

  List<TextCellValue> header = [
    TextCellValue('채취일자'),
    TextCellValue('농장명'),
    TextCellValue('농장주소'),
    TextCellValue('이력번호'),
    TextCellValue('채취자'),
    TextCellValue('소속기관')];

  toExcel(List<Collect> list) async {
    try{
      // 생성자에서 초기화
      excel = Excel.createExcel();
      sheet = excel['Sheet1'];
      CellStyle cellStyle = CellStyle(
        bold: true,
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
        fontSize: 12,
      );
      // 헤더 및 데이터 추가
      addHeaderAndData(list);
      for(int i = 0; i < list.length + 3; i++){
        for(int j = 0; j < 5; j++){
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i)).cellStyle = cellStyle;
        }
      }
      sheet.setDefaultColumnWidth(20);
      sheet.setColumnWidth(2, 80);
      sheet.setColumnWidth(3, 30);
      await saveExcel();
      print('엑셀 파일 생성 완료');
    } catch(e){
      print(e);
    }

  }

  void addHeaderAndData(List<Collect> list) {
    // 헤더 추가
    sheet.appendRow([TextCellValue(myInfo.name)]);
    sheet.appendRow([TextCellValue('')]);
    sheet.appendRow(header);

    // 데이터 추가
    for (var row in list) {
      List<TextCellValue> rowData = [
        TextCellValue('${row.createdAt.year}.${row.createdAt.month}.${row.createdAt.day}'),
        TextCellValue(row.farmName),
        TextCellValue(row.farmAddress),
        TextCellValue(row.identification),
        TextCellValue(row.scannerName),
        TextCellValue(row.affiliation)
      ];
      sheet.appendRow(rowData);
    }

  }

  // 엑셀 파일을 저장하거나 출력하는 메서드를 추가할 수 있음
  saveExcel() async {
    try {
      final directory = await getApplicationCacheDirectory();
        print(directory.path);
        final path = directory.path + '/${DateTime.now().millisecondsSinceEpoch.toString().replaceAll(':', '-')}.xlsx';
        File file = File(path);
        await file.writeAsBytes(excel.encode()!);

      String url = await excelUpload(file);

      // file.delete();
      // launchUrl(url);
      if (url.isNotEmpty) {
        Uri uri = Uri.parse(url);
        bool launched = await ul.launchUrl(uri);
        if (launched) {
          print('URL이 성공적으로 열렸습니다: $url');
        } else {
          print('URL 열기에 실패했습니다: $url');
        }
      } else {
        print(url);
        print('Error: Firebase Storage에서 URL을 가져오지 못했습니다.');
      }
        print('파일 저장 경로: $directory');
        // 파일 저장 로직 추가

        // File(join("$directory/sample.xlsx"))
        //   ..createSync(recursive: true)
        //   ..writeAsBytes(excel.encode()!);
      // }
    } catch (e) {
      print(e);
    }
  }
  Future<String> excelUpload(File excel) async {
    try {
      final storage = FirebaseStorage.instance;

      final fileName = 'excel/${DateTime.now().millisecondsSinceEpoch}.xlsx';
      final ref = storage.ref().child(fileName);

      // final file = File(excel);
      final uploadTask = ref.putFile(
        excel,
        SettableMetadata(contentType: 'xlsx'),
      );

      final snapshot = await uploadTask.whenComplete(() {});
      final downloadURL = await snapshot.ref.getDownloadURL();

      print(downloadURL);
      return downloadURL;
    } catch (e) {
      print('엑셀 업로드 에러 : ${e}');
      return '';
    }
  }
}
