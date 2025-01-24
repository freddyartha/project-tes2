import 'package:get/get.dart';

import '../controllers/pengaduan_setup_controller.dart';

class PengaduanSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengaduanSetupController>(
      () => PengaduanSetupController(),
    );
  }
}
