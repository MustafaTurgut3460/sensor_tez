import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sensor_tez/models/notification.dart';
import 'package:sensor_tez/pages/main_page.dart';
import 'package:sensor_tez/services/storage_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel notificationChannel =
    AndroidNotificationChannel("deneme", "deneme123",
        description: "aciklama deneme");

const TEMPERATURE_MAX = 25;
const TEMPERATURE_MIN = 18;
const AIR_QUALITY = 800;
const HUMIDITY_MAX = 60;
const HUMIDITY_MIN = 30;
const LIGHT = 100;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  runApp(const MyApp());
}

@pragma("vm:entry-point")
void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();

  service.on("setAsForeground").listen((event) {
    print("foregorund");
  });

  service.on("setAsBackground").listen((event) {
    print("foregorund");
  });

  service.on("stopService").listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 3), (timer) async {
    final temperature = double.parse(await StorageService.getStringData("temperature"));
    final air_quality = double.parse(await StorageService.getStringData("air_quality"));
    final humidity = double.parse(await StorageService.getStringData("humidity"));
    final light = double.parse(await StorageService.getStringData("light"));

    print("Sıcaklık: ${temperature}");

    if (temperature > TEMPERATURE_MAX) {
      showNotification("Aykırı Sıcaklık Değeri",
          "Sıcaklık değeri normal değerin üstünde: ${temperature}");
      insertNotification(NotificationModel(
          title: "Aykırı Sıcaklık Değeri",
          body:
              "Sıcaklık değeri normal değerin üstünde: ${temperature}. Isıtıcı çalıştırıldı.",
          date: ""));
    }
    if (temperature < TEMPERATURE_MIN) {
      showNotification("Aykırı Sıcaklık Değeri",
          "Sıcaklık değeri normal değerin altında: ${temperature}");
      insertNotification(NotificationModel(
          title: "Aykırı Sıcaklık Değeri",
          body:
              "Sıcaklık değeri normal değerin altında: ${temperature}. Fanlar çalıştırdı.",
          date: ""));
    }
    if (air_quality > AIR_QUALITY) {
      showNotification("Aykırı Hava Kalite Değeri",
          "Hava kalite değeri normal değerin dışında: ${air_quality}");
      insertNotification(NotificationModel(
          title: "Aykırı Hava Kalite Değeri",
          body: "Hava kalite değeri normal değerin dışında: ${air_quality}",
          date: ""));
    }
    if (humidity > HUMIDITY_MAX) {
      showNotification("Aykırı Nem Değeri",
          "Nem değeri normal değerin üstünde: ${humidity}");
      insertNotification(NotificationModel(
          title: "Aykırı Nem Değeri",
          body: "Nem değeri normal değerin üstünde: ${humidity}",
          date: ""));
    }
    if (humidity < HUMIDITY_MIN) {
      showNotification("Aykırı Nem Değeri",
          "Nem değeri normal değerin altında: ${humidity}");
      insertNotification(NotificationModel(
          title: "Aykırı Nem Değeri",
          body: "Nem değeri normal değerin altında: ${humidity}",
          date: ""));
    }
    if (light < LIGHT) {
      showNotification(
          "Aykırı Işık Değeri", "Işık değeri normal değerin dışında: ${light}");
      insertNotification(NotificationModel(
          title: "Aykırı Işık Değeri",
          body: "Işık değeri normal değerin dışında: ${light}",
          date: ""));
    }
  });
}

void showNotification(String title, String desc) {
  flutterLocalNotificationsPlugin.show(
    91,
    title,
    desc,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        "deneme",
        "deneme123",
        ongoing: false,
        icon: "app_icon",
        playSound: false,
        importance: Importance.high,
      ),
    ),
  );
}

Future<void> initializeService() async {
  var service = FlutterBackgroundService();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(notificationChannel);

  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
        notificationChannelId: "deneme",
        initialNotificationContent: "",
        initialNotificationTitle: "",
        foregroundServiceNotificationId: 90,
      ));

  service.startService();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Poppins"),
      home: const MainPage(),
    );
  }
}
