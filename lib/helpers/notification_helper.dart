import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationHelper {
  static void triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: "basic_channel",
          title: "Deneme bildirimi",
          body: "Burası da deneme kısmı"),
    );
  }
}
