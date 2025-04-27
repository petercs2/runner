import 'package:get/get.dart';

import 'point_second_logic.dart';

class PointSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PointSecondLogic());
  }
}
