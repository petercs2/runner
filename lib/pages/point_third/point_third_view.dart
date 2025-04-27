import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_run/pages/point_third/pie_chart.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../db_point/point_entity.dart';
import 'point_third_logic.dart';

class PointThirdPage extends GetView<PointThirdLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: [
          const Icon(
            Icons.edit_note_outlined,
            size: 30,
            color: Colors.black,
          ).marginOnly(right: 20).gestures(onTap: () {
            controller.editInfoData();
          })
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<PointThirdLogic>(builder: (_) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              <Widget>[
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
              ].toRow(mainAxisAlignment: MainAxisAlignment.end),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: controller.infoEntity?.image == null
                    ? Image.asset(
                        'assets/head2.webp',
                        fit: BoxFit.cover,
                      )
                    : Image.memory(
                        controller.infoEntity!.image,
                        width: 93,
                        height: 93,
                        fit: BoxFit.cover,
                      ),
              ),
              Text(
                controller.infoEntity?.name ?? 'Running Man',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ).marginSymmetric(vertical: 10),
              <Widget>[
                const SizedBox(
                  width: double.infinity,
                  height: 48,
                ),
                <Widget>[
                  Container(
                    width: double.infinity,
                    height: 22,
                  ).decorated(
                      color: const Color(0xffdddfdd),
                      borderRadius: BorderRadius.circular(11)),
                  LayoutBuilder(builder: (_, max) {
                    return Obx(() {
                      return Container(
                        width:
                            max.maxWidth * controller.totalDistance.value / 10,
                        height: 22,
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          '${controller.todayDistance.value} km',
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        ),
                      ).decorated(
                          color: const Color(0xff3e98e5),
                          borderRadius: BorderRadius.circular(11));
                    });
                  }),
                ].toStack(),
                Positioned(
                    top: 0,
                    left: 5,
                    child: Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      child: const Text(
                        '2km',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ).decorated(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                            colors: [Color(0xff42f15c), Color(0xff1d80d4)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter))),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      child: const Text(
                        '10km',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ).decorated(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                            colors: [Color(0xff42a1f1), Color(0xff1d80d4)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)))
              ]
                  .toStack(alignment: Alignment.center)
                  .marginSymmetric(horizontal: 50),
              const SizedBox(
                height: 20,
              ),
              <Widget>[
                <Widget>[
                  Image.asset(
                    'assets/img8.webp',
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(() {
                    return Text(
                      '${controller.totalDistance.value} km',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    );
                  }),
                  const Text(
                    'Total distance',
                    style: TextStyle(color: Colors.grey),
                  )
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
                <Widget>[
                  Image.asset(
                    'assets/img9.webp',
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(() {
                    return Text(
                      '${(controller.totalDistance.value * 62)} kcal',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    );
                  }),
                  const Text(
                    'Calories',
                    style: TextStyle(color: Colors.grey),
                  )
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'History',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child: controller.barList.isEmpty
                    ? const Center(
                        child: Text('No data'),
                      )
                    : RunBarChart(data: controller.barList),
              )
            ].toColumn(),
          );
        }).marginAll(20)),
      ),
    );
  }
}
