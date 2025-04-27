import 'package:get/get.dart';

import 'point_error_logic.dart';

class PointErrorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PointErrorLogic());
  }
}
