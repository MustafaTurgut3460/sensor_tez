import 'package:flutter/material.dart';
import 'package:sensor_tez/models/notification.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final notifications = await fetchNotifications();
    setState(() {
      _notifications = notifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Bildirimler",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      deleteAllNotifications();
                    },
                    child: Text(
                      "Tümünü Temizle",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // ListView yerine burada bir liste yapısı oluşturun.
            ListView.builder(
              primary: false, // SingleChildScrollView içinde olduğu için bu önemli.
              shrinkWrap: true, // Bu, ListView'in tüm öğeleri çizmesini sağlar.
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: TW3Colors.gray.shade200,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: TW3Colors.gray.shade300)),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(_notifications[index].title),
                      subtitle: Text(_notifications[index].body),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
