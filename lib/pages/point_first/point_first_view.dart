import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'point_first_logic.dart';

class PointFirstPage extends StatefulWidget {
  const PointFirstPage({Key? key}) : super(key: key);

  @override
  State<PointFirstPage> createState() => _PointFirstPageState();
}

class _PointFirstPageState extends State<PointFirstPage> {
  PointFirstLogic controller = Get.find<PointFirstLogic>();

  void checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      Get.toNamed('/pointError');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<PointFirstLogic>(builder: (_) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              Container(
                width: double.infinity,
                height: 54,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(19),
                    child: controller.infoEntity == null
                        ? Image.asset(
                            'assets/head0.webp',
                            fit: BoxFit.cover,
                          )
                        : Image.memory(
                            controller.infoEntity!.image,
                            width: 38,
                            height: 38,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      controller.infoEntity?.name ?? 'Running Man',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Obx(() {
                    return Text(
                      controller.totalStar.value.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    );
                  }),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    'assets/star.webp',
                    fit: BoxFit.cover,
                  )
                ].toRow(),
              )
                  .decorated(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(27))
                  .gestures(onTap: () {
                Get.toNamed('/pointThird')?.then((_) {
                  controller.getData();
                });
              }),
              <Widget>[
                Image.asset(
                  'assets/line.png',
                  fit: BoxFit.cover,
                ).marginSymmetric(vertical: 15),
                Positioned(
                    bottom: 20,
                    left: 0,
                    child: <Widget>[
                      Image.asset(
                        'assets/img2.webp',
                        fit: BoxFit.cover,
                      ),
                      Visibility(
                        visible: controller.todayDistance > 0 &&
                            controller.todayDistance <= 2,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(19),
                            child: controller.infoEntity == null
                                ? Image.asset(
                                    'assets/head0.webp',
                                    fit: BoxFit.cover,
                                  )
                                : Image.memory(
                                    controller.infoEntity!.image,
                                    width: 38,
                                    height: 38,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        )
                            .decorated(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(29))
                            .marginOnly(bottom: 10),
                      ),
                    ].toStack(alignment: Alignment.center)),
                Positioned(
                    bottom: 158,
                    left: 50,
                    child: <Widget>[
                      Visibility(
                        visible: controller.todayDistance > 2 &&
                            controller.todayDistance < 10,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(19),
                            child: controller.infoEntity == null
                                ? Image.asset(
                                    'assets/head0.webp',
                                    fit: BoxFit.cover,
                                  )
                                : Image.memory(
                                    controller.infoEntity!.image,
                                    width: 38,
                                    height: 38,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        )
                            .decorated(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(29))
                            .marginOnly(top: 22),
                      ),
                    ].toStack(alignment: Alignment.center)),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: <Widget>[
                      Visibility(
                        visible: controller.todayDistance == 0,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(19),
                            child: controller.infoEntity == null
                                ? Image.asset(
                                    'assets/head0.webp',
                                    fit: BoxFit.cover,
                                  )
                                : Image.memory(
                                    controller.infoEntity!.image,
                                    width: 38,
                                    height: 38,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ).decorated(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(29)),
                      ),
                    ].toStack(alignment: Alignment.center)),
                Positioned(
                    bottom: 200,
                    right: 0,
                    child: <Widget>[
                      Image.asset(
                        'assets/img0.webp',
                        fit: BoxFit.cover,
                      ),
                      Visibility(
                        visible: controller.todayDistance == 10,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(19),
                            child: controller.infoEntity == null
                                ? Image.asset(
                                    'assets/head0.webp',
                                    fit: BoxFit.cover,
                                  )
                                : Image.memory(
                                    controller.infoEntity!.image,
                                    width: 38,
                                    height: 38,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        )
                            .decorated(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(29))
                            .marginOnly(top: 22),
                      ),
                      Positioned(
                          bottom: 35,
                          right: 0,
                          child: <Widget>[
                            Image.asset(
                              'assets/star.webp',
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              controller.distance10Star.value.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            )
                          ].toStack(alignment: Alignment.center))
                    ].toStack(alignment: Alignment.center)),
                Positioned(
                    top: 140,
                    right: 80,
                    child: <Widget>[
                      Visibility(
                        visible: controller.todayDistance > 10 &&
                            controller.todayDistance < 20,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(19),
                            child: controller.infoEntity == null
                                ? Image.asset(
                                    'assets/head0.webp',
                                    fit: BoxFit.cover,
                                  )
                                : Image.memory(
                                    controller.infoEntity!.image,
                                    width: 38,
                                    height: 38,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        )
                            .decorated(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(29))
                            .marginOnly(top: 22),
                      ),
                    ].toStack(alignment: Alignment.center)),
                Positioned(
                    top: 100,
                    left: 0,
                    child: <Widget>[
                      Image.asset(
                        'assets/img1.webp',
                        fit: BoxFit.cover,
                      ),
                      Visibility(
                        visible: controller.todayDistance == 20,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(19),
                            child: controller.infoEntity == null
                                ? Image.asset(
                                    'assets/head0.webp',
                                    fit: BoxFit.cover,
                                  )
                                : Image.memory(
                                    controller.infoEntity!.image,
                                    width: 38,
                                    height: 38,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        )
                            .decorated(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(29))
                            .marginOnly(top: 22),
                      ),
                      Positioned(
                          bottom: 35,
                          right: 0,
                          child: <Widget>[
                            Image.asset(
                              'assets/star.webp',
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              controller.distance20Star.value.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            )
                          ].toStack(alignment: Alignment.center))
                    ].toStack(alignment: Alignment.center)),
              ].toStack().marginSymmetric(vertical: 30),
              Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: double.infinity,
                  child: <Widget>[
                    Image.asset(
                      'assets/img3.webp',
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Start run',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ].toRow(mainAxisAlignment: MainAxisAlignment.center),
                ).decorated(
                    borderRadius: BorderRadius.circular(26),
                    gradient: const LinearGradient(
                        colors: [Color(0xfff3d70b), Color(0xfffa7704)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
              )
                  .decorated(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30))
                  .gestures(onTap: () {
                Get.toNamed('/pointSecond');
              })
            ].toColumn(),
          );
        }).marginAll(15)),
      ).decorated(
          image: const DecorationImage(
              image: AssetImage('assets/bg.webp'), fit: BoxFit.fill)),
    );
  }
}
