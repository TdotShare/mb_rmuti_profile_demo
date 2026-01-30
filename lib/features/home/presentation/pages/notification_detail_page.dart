import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/home/data/models/home_user_notification_list_model.dart';

class NotificationDetailPage extends StatelessWidget {
  final HomeUserNotificationListModel notification;

  const NotificationDetailPage({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('รายละเอียด')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.mail_outline, size: 48, color: Color(0xFFFF8A00)),
            const SizedBox(height: 16),
            Text(
              notification.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 32),
            Text(
              notification.detail,
              style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}