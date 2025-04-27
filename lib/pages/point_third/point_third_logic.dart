import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:point_run/db_point/db_point.dart';
import 'package:point_run/pages/point_third/point_text_field.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../db_point/point_entity.dart';

class PointThirdLogic extends GetxController {
  DBPoint dbPoint = Get.find();

  InfoEntity? infoEntity;
  Uint8List? image;

  var list = <PointEntity>[].obs;
  var totalStar = 0.obs;
  var distance10Star = 0;
  var distance20Star = 0;
  var totalDistance = 0.0.obs;
  var todayDistance = 0.0.obs;
  var kcal = 0.0.obs;
  List<RunData> barList = [];

  void getData() async {
    list.value = await dbPoint.getPointAllData();
    distance10Star = 0;
    distance20Star = 0;
    totalStar.value = 0;
    totalDistance.value = 0;
    for (var element in list.value) {
      if (double.parse(element.distance) >= 20) {
        distance20Star += 1;
      } else if (double.parse(element.distance) < 20 &&
          double.parse(element.distance) >= 10) {
        distance10Star += 1;
      }
    }
    totalStar.value = distance10Star + distance20Star;
    if (list.value.isEmpty) {
      totalDistance.value = 0.0;
    } else {
      totalDistance.value = list.value.fold(
          0.0,
          (previousValue, element) =>
              previousValue + double.parse(element.distance));
    }
    final now = DateTime.now();
    final todayResult = list.value
        .where((e) =>
            e.createdTime.year == now.year &&
            e.createdTime.month == now.month &&
            e.createdTime.day == now.day)
        .toList();
    if (todayResult.isEmpty) {
      todayDistance.value = 0.0;
    } else {
      todayDistance.value = todayResult.fold(
          0.0,
          (previousValue, element) =>
              previousValue + double.parse(element.distance));
    }

    barList.clear();
    final sevenDayData = await dbPoint.fetchLast7DaysData();
    for (var item in sevenDayData) {
      final en = RunData(
          date: item.createdTime, distance: double.parse(item.distance));
      barList.add(en);
    }

    infoEntity = await dbPoint.getInfoData();

    update();
  }

  void imageSelected() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
          imageQuality: 90, maxWidth: 1024, source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        image = imageBytes;
        infoEntity?.image = image!;
        update(['head']);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Please check album permissions or select a new image');
      return;
    }
  }

  editInfoData() async {
    if (infoEntity != null) {
      image = infoEntity?.image;
    }
    String name = infoEntity?.name ?? 'Running Man';
    Get.dialog(AlertDialog(
      title: null,
      content: GetBuilder<PointThirdLogic>(
          id: 'head',
          builder: (_) {
            return SizedBox(
              height: 280,
              child: <Widget>[
                <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: image == null
                        ? Image.asset(
                            'assets/img10.webp',
                            fit: BoxFit.cover,
                          )
                        : Image.memory(
                            image!,
                            width: 135,
                            height: 135,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/img11.webp',
                        fit: BoxFit.cover,
                      ))
                ].toStack().gestures(onTap: () {
                  imageSelected();
                }),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: PointTextField(
                      maxLength: 20,
                      hintText: 'Name',
                      value: name,
                      onChange: (v) {
                        name = v;
                      }),
                ).decorated(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300)),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
                    .decorated(
                        gradient: const LinearGradient(
                            colors: [Color(0xfff3d70b), Color(0xfffa7704)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.circular(25))
                    .gestures(onTap: () async {
                  if (image == null) {
                    Fluttertoast.showToast(msg: 'Please select an image');
                    return;
                  }
                  if (name.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please enter your name');
                    return;
                  }
                  if (infoEntity == null) {
                    infoEntity = InfoEntity(
                        id: 0,
                        createdTime: DateTime.now(),
                        name: name,
                        image: image!);
                    await dbPoint.insertInfoData(infoEntity!);
                  } else {
                    infoEntity!.name = name;
                    infoEntity!.image = image!;
                    await dbPoint.updateInfoData(infoEntity!);
                  }
                  getData();
                  Get.back();
                })
              ].toColumn(),
            );
          }),
    ));
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
