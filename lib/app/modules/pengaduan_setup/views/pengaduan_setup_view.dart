import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_tes2/app/components/inputs/input_file_component.dart';
import 'package:project_tes2/app/components/inputs/input_text_component.dart';
import 'package:project_tes2/app/components/mahas_colors.dart';
import 'package:project_tes2/app/components/mahas_font_size.dart';
import 'package:project_tes2/app/components/others/button_component.dart';
import 'package:project_tes2/app/components/texts/text_component.dart';

import '../controllers/pengaduan_setup_controller.dart';

class PengaduanSetupView extends GetView<PengaduanSetupController> {
  const PengaduanSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: TextComponent(
          value: "Tambah Pengaduan",
          fontSize: MahasFontSize.actionBartitle,
          fontColor: MahasColors.light,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.left,
        ),
        backgroundColor: MahasColors.primary,
      ),
      body: SafeArea(
        child: Card(
          margin: EdgeInsets.all(10),
          elevation: 5,
          child: Container(
            width: Get.width,
            height: Get.height,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              // spacing: 20,
              children: [
                TextComponent(
                  value: "Laporkan Aduan Anda",
                  fontSize: MahasFontSize.h6,
                  fontWeight: FontWeight.w600,
                  margin: EdgeInsets.only(bottom: 20),
                ),
                Expanded(
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    children: [
                      InputTextComponent(
                        label: "NIK",
                        required: true,
                        placeHolder: "Masukkan NIK anda",
                        controller: controller.nikCon,
                      ),
                      InputTextComponent(
                        label: "Nama",
                        required: true,
                        placeHolder: "Masukkan Nama anda",
                        controller: controller.namaCon,
                      ),
                      InputTextComponent(
                        label: "No.HP",
                        required: true,
                        placeHolder: "Masukkan No. HP anda",
                        controller: controller.noHpCon,
                      ),
                      InputTextComponent(
                        label: "E-mail",
                        required: true,
                        placeHolder: "Masukkan E-mail anda",
                        controller: controller.emailCon,
                      ),
                      InputTextComponent(
                        label: "Alamat Pengirim Aduan",
                        required: true,
                        placeHolder: "Masukkan alamat anda",
                        controller: controller.alamatCon,
                      ),
                      InputTextComponent(
                        label: "Judul Aduan",
                        required: true,
                        placeHolder: "Masukkan judul aduan anda",
                        controller: controller.judulAduanCon,
                      ),
                      InputTextComponent(
                        label: "Deskripsi Aduan",
                        required: true,
                        placeHolder: "Masukkan deskripsi aduan anda",
                        controller: controller.deskripsiAduanCon,
                      ),
                      InputFileComponent(
                        placeHolder: "Tambahkan lapiran berupa gambar",
                        controller: controller.fileCon,
                      ),
                      ButtonComponent(
                        onTap: controller.simpanOnTap,
                        text: "Kirim Pengaduan",
                        btnColor: MahasColors.primary,
                        textColor: MahasColors.light,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
