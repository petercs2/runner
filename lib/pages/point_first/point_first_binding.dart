import 'package:get/get.dart';

import 'point_first_logic.dart';

class PointFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PointFirstLogic());
  }
}
