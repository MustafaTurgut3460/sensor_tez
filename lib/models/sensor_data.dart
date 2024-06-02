import 'package:sensor_tez/helpers/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class SensorData {
  final int? id;
  final double temperature;
  final double air_quality;
  final double humidity;
  final double light;
  final double watt;

  SensorData({
    this.id,
    required this.temperature,
    required this.air_quality,
    required this.humidity,
    required this.light,
    required this.watt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'temperature': temperature,
      'air_quality': air_quality,
      'humidity': humidity,
      'light': light,
      'watt': watt,
    };
  }

  factory SensorData.fromMap(Map<String, dynamic> map) {
    return SensorData(
      id: map['id'],
      temperature: map['temperature'],
      air_quality: map['air_quality'],
      humidity: map['humidity'],
      light: map['light'],
      watt: map['watt'],
    );
  }
}

Future<void> insertSensorData(SensorData data) async {
  final db = await DatabaseHelper.instance.database;

  await db.insert(
    'sensor_data',
    data.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<SensorData?> fetchLatestSensorData() async {
  final db = await DatabaseHelper.instance.database;

  final List<Map<String, dynamic>> maps = await db.query(
    'sensor_data',
    orderBy: 'id DESC',
    limit: 1,
  );

  if (maps.isNotEmpty) {
    return SensorData.fromMap(maps.first);
  } else {
    return null;
  }
}
