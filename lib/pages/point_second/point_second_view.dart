import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:styled_widget/styled_widget.dart';

import 'point_second_logic.dart';

class PointSecondPage extends StatefulWidget {
  const PointSecondPage({Key? key}) : super(key: key);

  @override
  State<PointSecondPage> createState() => _PointSecondPageState();
}

class _PointSecondPageState extends State<PointSecondPage> {
  PointSecondLogic controller = Get.find<PointSecondLogic>();

  StreamSubscription<Position>? _positionStreamSubscription;
  Position? _lastPosition;

  List<String> types = ["Year", 'Month', 'Day'];

  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;

  Future<void> _initAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    await _player.setLoopMode(LoopMode.all);
  }

  Future<void> _loadAudio() async {
    try {
      await _player.setAsset('assets/sound.mp3');
    } catch (e) {
      print("Error: $e");
    }
    _togglePlay();
  }

  Future<void> _togglePlay() async {
    if (_isPlaying) {
      _isPlaying = false;
      await _player.pause();
    } else {
      _isPlaying = true;
      await _player.play();
    }
  }

  Future<void> _checkLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      _startListening();
    } else {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Location permissions required'),
        content: const Text('Please grant location permission to get distance'),
        actions: [
          TextButton(
            onPressed: () => openAppSettings(),
            child: const Text('Setting'),
          ),
        ],
      ),
    );
  }

  void _startListening() {
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      ),
    ).listen((Position position) {
      if (_lastPosition != null) {
        final distanceInMeters = Geolocator.distanceBetween(
          _lastPosition!.latitude,
          _lastPosition!.longitude,
          position.latitude,
          position.longitude,
        );
        controller.distance.value += distanceInMeters / 1000;
      }
      _lastPosition = position;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _checkLocationPermission();
    _initAudioSession();
    _loadAudio();
    super.initState();
  }

  void _resetAllData() {
    _lastPosition = null;
    controller.distance.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff36b54b),
      appBar: AppBar(
        title: const Text(
          'Run',
          style: TextStyle(color: Colors.white),
        ),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
          bottom: false,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: <Widget>[
              Image.asset(
                'assets/img4.webp',
                fit: BoxFit.cover,
              ).marginOnly(top: 30),
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: GetBuilder<PointSecondLogic>(builder: (_) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: <Widget>[
                      Image.asset(
                        'assets/arrow.webp',
                        fit: BoxFit.cover,
                      ).marginOnly(top: 30),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return Text(
                          controller.distance.value.toString(),
                          style: const TextStyle(
                              fontSize: 95,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        );
                      }),
                      const Text(
                        'Distance (km)',
                        style: TextStyle(fontSize: 24, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 102,
                        child: Obx(() {
                          return controller.list.value.isEmpty
                              ? const Center(
                                  child: Text(
                                    '''You haven't recorded it yet''',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              : GridView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 92 / 114),
                                  itemCount: controller.list.value.length - 1,
                                  itemBuilder: (_, index) {
                                    final entity = controller.list.value[index];
                                    return <Widget>[
                                      Image.asset(
                                        'assets/img8.webp',
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        '${entity.distance} km',
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        'Total distance ',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text('(${types[index]})',style: TextStyle(color: Colors.grey),),
                                    ].toColumn();
                                  });
                        }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      <Widget>[
                        const SizedBox(
                          height: 60,
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
                                width: max.maxWidth *
                                    controller.distance.value /
                                    10,
                                height: 22,
                              );
                            }).decorated(
                                color: const Color(0xff3e98e5),
                                borderRadius: BorderRadius.circular(11));
                          }),
                        ].toStack().marginOnly(bottom: 20, left: 10, right: 10),
                        Image.asset(
                          'assets/img0.webp',
                          fit: BoxFit.cover,
                        )
                      ]
                          .toStack(alignment: Alignment.bottomRight)
                          .marginSymmetric(horizontal: 20),
                      const SizedBox(
                        height: 30,
                      ),
                      <Widget>[
                        Image.asset(
                          'assets/img6.webp',
                          fit: BoxFit.cover,
                        ).gestures(onTap: () {
                          _resetAllData();
                        }),
                        Image.asset(
                          'assets/img5.webp',
                          fit: BoxFit.cover,
                        ).gestures(onTap: () {
                          controller.addData();
                          Get.back();
                        }),
                        Image.asset(
                          'assets/img7.webp',
                          fit: BoxFit.cover,
                        ).gestures(onTap: () {
                          _togglePlay();
                        })
                      ]
                          .toRow(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween)
                          .marginSymmetric(horizontal: 30)
                    ].toColumn(),
                  );
                }),
              )
            ].toStack(alignment: Alignment.topCenter),
          )
              .decorated(
                  color: const Color(0xfff7f7f7),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)))
              .marginOnly(top: 15)),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
