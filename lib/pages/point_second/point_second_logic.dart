import 'package:get/get.dart';
import 'package:point_run/db_point/db_point.dart';
import 'package:point_run/db_point/point_entity.dart';

class PointSecondLogic extends GetxController {
  DBPoint dbPoint = Get.find();

  var list = <PointEntity>[].obs;

  var distance = 0.0.obs;

  void getData() async {
    final result = await dbPoint.getPointAllData();
    final now = DateTime.now();
    list.value = result
        .where((element) =>
            element.createdTime.year == now.year &&
            element.createdTime.month == now.month &&
            element.createdTime.day == now.day)
        .toList();

  }

  void addData() async {
    final now = DateTime.now();
    await dbPoint.insertPointData(PointEntity(
        id: 0,
        createdTime: DateTime(now.year,now.month,now.day),
        distance: distance.value.toString()));
    getData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }
}
