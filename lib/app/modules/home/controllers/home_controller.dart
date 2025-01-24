import 'package:get/get.dart';
import 'package:project_tes2/app/routes/app_pages.dart';

class HomeController extends GetxController {
  bool isAdmin = Get.arguments["isAdmin"];

  void addOnTap() {
    Get.toNamed(Routes.PENGADUAN_SETUP);
  }

  void logoutOnTap() {
    Get.offAllNamed(Routes.LOGIN);
  }
}
