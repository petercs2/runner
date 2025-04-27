import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PointErrorLogic extends GetxController {

  void qmgoihaonxc() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      Fluttertoast.showToast(msg: 'Check the network and try again');
    } else {
      Fluttertoast.showToast(msg: 'You are connected to the internet');
      Get.back();
    }
  }

}
