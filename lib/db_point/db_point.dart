import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:point_run/db_point/point_entity.dart';
import 'package:sqflite/sqflite.dart';

class DBPoint extends GetxService {
  late Database dbBase;

  Future<DBPoint> init() async {
    await createPointDB();
    return this;
  }

  createPointDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'point.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createPointTable(db);
          await createInfoTable(db);
        });
  }

  createPointTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS point (id INTEGER PRIMARY KEY, createdTime TEXT, distance TEXT)');
  }

  createInfoTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS info (id INTEGER PRIMARY KEY, createdTime TEXT, image BLOB, name TEXT)');
  }

  insertPointData(PointEntity speedEntity) async {
    final id = await dbBase.insert('point', {
      'createdTime': speedEntity.createdTime.toIso8601String(),
      'distance': speedEntity.distance,
    });
    return id;
  }

  insertInfoData(InfoEntity entity) async {
    final id = await dbBase.insert('info', {
      'createdTime': entity.createdTime.toIso8601String(),
      'image': entity.image,
      'name': entity.name,
    });
    return id;
  }

  updateInfoData(InfoEntity entity) async {
    final id = await dbBase.update('info', {
      'createdTime': entity.createdTime.toIso8601String(),
      'image': entity.image,
      'name': entity.name,
    });
    return id;
  }

  Future<List<PointEntity>> getPointAllData() async {
    var result = await dbBase.query('point', orderBy: 'createdTime ASC');
    return result.map((e) => PointEntity.fromJson(e)).toList();
  }

  Future<List<PointEntity>> fetchLast7DaysData() async {
    final DateTime now = DateTime.now();
    final DateTime sevenDaysAgo = now.subtract(const Duration(days: 6));

    final String startDate = sevenDaysAgo.toIso8601String();
    final String endDate = now.toIso8601String();

    final List<Map<String, dynamic>> results = await dbBase.rawQuery('''
    SELECT id, createdTime,
      PRINTF('%.2f', SUM(CAST(distance AS REAL))) AS distance 
    FROM point 
    WHERE createdTime BETWEEN ? AND ? 
    GROUP BY createdTime 
    ORDER BY createdTime ASC
  ''', [startDate, endDate]);
    return results.map((e) => PointEntity.fromJson(e)).toList();
  }

  Future<InfoEntity?> getInfoData() async {
    var result = await dbBase.query('info', orderBy: 'createdTime ASC');
    if (result.isEmpty) {
      return null;
    }
    final first = result.first;
    return InfoEntity.fromJson(first);
  }
}
