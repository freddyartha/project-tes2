import 'package:get/get.dart';
import 'package:project_tes2/app/components/inputs/input_text_component.dart';
import 'package:project_tes2/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final emailCon = InputTextController(type: InputTextType.email);
  final passwordCon = InputTextController(type: InputTextType.password);

  void gotoHome() {
    if (emailCon.isValid && passwordCon.isValid) {
      Get.offAllNamed(Routes.HOME, arguments: {
        "isAdmin": false,
      });
    }
  }

  void goToAdmin() {
    Get.offAllNamed(Routes.HOME, arguments: {
      "isAdmin": true,
    });
  }
}
