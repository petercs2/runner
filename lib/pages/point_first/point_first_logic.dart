import 'package:get/get.dart';

import '../../db_point/db_point.dart';
import '../../db_point/point_entity.dart';

class PointFirstLogic extends GetxController {
  DBPoint dbPoint = Get.find();

  var list = <PointEntity>[].obs;

  InfoEntity? infoEntity;

  var totalStar = 0.obs;
  var distance10Star = 0.obs;
  var distance20Star = 0.obs;
  var todayDistance = 0.0;

  void getData() async {
    final result = await dbPoint.getPointAllData();
    final now = DateTime.now();
    list.value = result;
    totalStar.value = 0;
    distance10Star.value = 0;
    distance20Star.value = 0;
    for (var element in list.value) {
      if (double.parse(element.distance) >= 20) {
        distance20Star += 1;
      } else if (double.parse(element.distance) < 20 &&
          double.parse(element.distance) >= 10) {
        distance10Star += 1;
      }
    }
    totalStar.value = distance10Star.value + distance20Star.value;
    final todayResult = result
        .where((e) =>
            e.createdTime.year == now.year &&
            e.createdTime.month == now.month &&
            e.createdTime.day == now.day)
        .toList();
    if (todayResult.isEmpty) {
      todayDistance = 0.0;
    } else {
      todayDistance = todayResult.fold(
          0.0,
          (previousValue, element) =>
              previousValue + double.parse(element.distance));
    }

    infoEntity = await dbPoint.getInfoData();
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }
}
