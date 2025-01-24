import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:project_tes2/app/components/inputs/input_file_component.dart';
import 'package:project_tes2/app/components/inputs/input_text_component.dart';
import 'package:project_tes2/app/components/mahas_widget.dart';

class PengaduanSetupController extends GetxController {
  final nikCon = InputTextController(type: InputTextType.ktp);
  final namaCon = InputTextController();
  final noHpCon = InputTextController(type: InputTextType.number);
  final emailCon = InputTextController(type: InputTextType.email);
  final alamatCon = InputTextController(type: InputTextType.paragraf);
  final judulAduanCon = InputTextController(type: InputTextType.paragraf);
  final deskripsiAduanCon = InputTextController(type: InputTextType.paragraf);
  final fileCon =
      InputFileController(tipe: InputFileType.camera, isGetPath: true);

  void simpanOnTap() async {
    if (nikCon.isValid &&
        namaCon.isValid &&
        noHpCon.isValid &&
        emailCon.isValid &&
        alamatCon.isValid &&
        judulAduanCon.isValid &&
        deskripsiAduanCon.isValid) {
      bool? question = await MahasWidget.dialogConfirmation(
          title: "Anda yakin ingin mengirim laporan aduan ini?",
          textConfirm: "Ya",
          textCancel: "Tidak");
      if (question == true) {
        EasyLoading.show();
        Future.delayed(Duration(seconds: 4)).then(
          (value) {
            EasyLoading.dismiss();
            MahasWidget.dialogSuccess("Laporan aduan berhasil dikirim");
          },
        );
      }
    }
  }
}
