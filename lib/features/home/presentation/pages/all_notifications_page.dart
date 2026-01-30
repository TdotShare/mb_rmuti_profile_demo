import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/home/data/models/home_user_notification_list_model.dart';
import 'package:mb_rmuti_profile_demo/features/home/presentation/pages/notification_detail_page.dart';

// --- 1. หน้าแสดงการแจ้งเตือนทั้งหมด ---
class AllNotificationsPage extends StatelessWidget {
  final List<HomeUserNotificationListModel> notifications;

  const AllNotificationsPage({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('การแจ้งเตือนทั้งหมด', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return _buildNotifCard(context, item);
        },
      ),
    );
  }

  Widget _buildNotifCard(BuildContext context, HomeUserNotificationListModel item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFFF8A00),
          child: Icon(Icons.notifications_none, color: Colors.white),
        ),
        title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(item.detail, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {
          // --- 2. คลิกแล้วไปหน้าอ่านรายละเอียด ---
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationDetailPage(notification: item),
            ),
          );
        },
      ),
    );
  }
}