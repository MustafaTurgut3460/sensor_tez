import 'dart:async';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sensor_tez/helpers/notification_helper.dart';
import 'package:sensor_tez/pages/main_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel notificationChannel =
    AndroidNotificationChannel("deneme", "deneme123",
        description: "aciklama deneme");

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

  Timer.periodic(Duration(seconds: 10), (timer) {
    flutterLocalNotificationsPlugin.show(
        91,
        "Denemeeee",
        "Burası da deneme açıklama işte Zaman: ${DateTime.now()}",
        const NotificationDetails(
            android: AndroidNotificationDetails("deneme", "deneme123",
                ongoing: false,
                icon: "app_icon",
                playSound: false,
                importance: Importance.high)));
  });
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
