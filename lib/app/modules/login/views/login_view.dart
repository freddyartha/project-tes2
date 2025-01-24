import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_tes2/app/components/images/image_component.dart';
import 'package:project_tes2/app/components/inputs/input_text_component.dart';
import 'package:project_tes2/app/components/mahas_colors.dart';
import 'package:project_tes2/app/components/mahas_font_size.dart';
import 'package:project_tes2/app/components/others/button_component.dart';
import 'package:project_tes2/app/components/texts/text_component.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('HomeView'),
      //   centerTitle: true,
      // ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MahasColors.primary,
              MahasColors.light,
              // Color(0xFF2A84C1),
              // Color(0xFF5BB896),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            ImageComponent(
              svgUrl: "assets/png/applogo.png",
              width: Get.width * 0.4,
            ),
            TextComponent(
              value:
                  "Selamat Data di Aplikasi Laporan Masyarakat Diskominfo Badung",
              textAlign: TextAlign.center,
              fontSize: MahasFontSize.h6,
              fontWeight: FontWeight.bold,
            ),
            TextComponent(
              value: "Masuk Menggunakan Email dan Password",
              textAlign: TextAlign.center,
            ),
            InputTextComponent(
              label: "E-mail",
              required: true,
              placeHolder: "Masukkan email anda",
              controller: controller.emailCon,
            ),
            InputTextComponent(
              label: "Pasword",
              required: true,
              controller: controller.passwordCon,
            ),
            ButtonComponent(
              onTap: controller.gotoHome,
              text: "Masuk",
              btnColor: MahasColors.primary,
              textColor: MahasColors.light,
            ),
            TextComponent(
              onTap: () => controller.goToAdmin(),
              value: "Masuk Sebagai Admin",
              fontColor: MahasColors.primary,
              textAlign: TextAlign.center,
              margin: EdgeInsets.all(20),
            ),
          ],
        ),
      ),
    );
  }
}
