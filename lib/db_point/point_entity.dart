import 'dart:typed_data';

import 'package:intl/intl.dart';

class PointEntity {
  int id;
  DateTime createdTime;
  String distance;

  PointEntity({
    required this.id,
    required this.createdTime,
    required this.distance,
  });

  factory PointEntity.fromJson(Map<String, dynamic> json) {
    return PointEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      distance: json['distance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'distance': distance,
    };
  }

  String get createdTimeString {
    return DateFormat('MM/dd').format(createdTime);
  }
}

class InfoEntity {
  int id;
  DateTime createdTime;
  Uint8List image;
  String name;

  InfoEntity({
    required this.id,
    required this.createdTime,
    required this.image,
    required this.name,
  });

  factory InfoEntity.fromJson(Map<String, dynamic> json) {
    return InfoEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      image: json['image'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'image': image,
      'name': name,
    };
  }
}

class RunData {
  final DateTime date;
  final double distance;

  RunData({required this.date, required this.distance});
}