import 'package:sensor_tez/helpers/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class NotificationModel {
  final int? id;
  final String title;
  final String body;
  final String date;

  NotificationModel({this.id, required this.title, required this.body, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'date': date,
    };
  }
}

Future<void> insertNotification(NotificationModel notification) async {
  final db = await DatabaseHelper.instance.database;

  await db.insert(
    'notifications',
    notification.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<NotificationModel>> fetchNotifications() async {
  final db = await DatabaseHelper.instance.database;

  // En son eklenen 20 bildirimi çek
  final List<Map<String, dynamic>> maps = await db.query(
    'notifications',
    orderBy: 'id DESC',  // En son eklenenler başta olacak şekilde sırala
    limit: 20  // Yalnızca en son 20 bildirimi getir
  );

  return List.generate(maps.length, (i) {
    return NotificationModel(
      id: maps[i]['id'],
      title: maps[i]['title'],
      body: maps[i]['body'],
      date: maps[i]['date'],
    );
  });
}



Future<void> deleteNotification(int id) async {
  final db = await DatabaseHelper.instance.database;
  await db.delete(
    'notifications',
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<void> deleteAllNotifications() async {
  final db = await DatabaseHelper.instance.database;
  await db.delete('notifications');  // Tablodaki tüm satırları siler
}
