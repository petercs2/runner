import 'package:get/get.dart';

import 'point_end_logic.dart';

class PointEndBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
