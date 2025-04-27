import 'package:get/get.dart';

import 'point_third_logic.dart';

class PointThirdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PointThirdLogic());
  }
}
