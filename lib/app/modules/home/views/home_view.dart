import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_tes2/app/components/mahas_colors.dart';
import 'package:project_tes2/app/components/mahas_font_size.dart';
import 'package:project_tes2/app/components/mahas_format.dart';
import 'package:project_tes2/app/components/texts/text_component.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: controller.isAdmin
          ? null
          : InkWell(
              onTap: controller.addOnTap,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MahasColors.primary,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: MahasColors.light,
                ),
              ),
            ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: TextComponent(
          value: "Beranda",
          fontSize: MahasFontSize.actionBartitle,
          fontColor: MahasColors.light,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.left,
        ),
        backgroundColor: MahasColors.primary,
        actions: [
          InkWell(
            onTap: controller.logoutOnTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.logout_outlined,
                size: 25,
                color: MahasColors.light,
              ),
            ),
          )
        ],
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
              children: [
                TextComponent(
                  value: "Laporan Pengaduan",
                  fontSize: MahasFontSize.h6,
                  fontWeight: FontWeight.w600,
                  margin: EdgeInsets.only(bottom: 20),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: 25,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) => ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      title: TextComponent(
                        value: "Laporan ${index + 1}",
                        fontWeight: FontWeight.w600,
                      ),
                      leading: Icon(
                        Icons.report_outlined,
                        size: 30,
                        color: MahasColors.primary,
                      ),
                      horizontalTitleGap: 10,
                      subtitle: TextComponent(
                        value:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                        maxLines: 2,
                      ),
                      trailing: TextComponent(
                        value:
                            MahasFormat.displayDate(DateTime.now(), mini: true),
                      ),
                    ),
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
