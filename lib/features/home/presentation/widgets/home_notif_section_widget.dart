import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/home/data/models/home_user_notification_list_model.dart';
import 'package:mb_rmuti_profile_demo/features/home/presentation/pages/all_notifications_page.dart';
import 'package:mb_rmuti_profile_demo/features/home/presentation/pages/notification_detail_page.dart';
// Import หน้าใหม่ที่คุณเพิ่งสร้างด้านบน
// import 'package:your_path/notification_pages.dart'; 

class HomeNotifSectionWidget extends StatelessWidget {
  final List<HomeUserNotificationListModel> notifications;

  const HomeNotifSectionWidget({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    // กรองเอาแค่ 5 รายการแรก
    final displayedNotifs = notifications.take(5).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // ส่วนหัว + ปุ่มดูทั้งหมด
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'การแจ้งเตือนล่าสุด',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (notifications.length > 5)
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllNotificationsPage(notifications: notifications),
                      ),
                    );
                  },
                  child: const Text('ดูทั้งหมด', style: TextStyle(color: Color(0xFFFF8A00))),
                ),
            ],
          ),
          const SizedBox(height: 8),
          
          // รายการแจ้งเตือน
          ListView.separated(
            shrinkWrap: true, // สำคัญ: เพื่อให้ใช้ร่วมกับ Column ได้
            physics: const NeverScrollableScrollPhysics(), // ปิดการ scroll ในตัวมันเอง
            padding: EdgeInsets.zero,
            itemCount: displayedNotifs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = displayedNotifs[index];
              return _buildSimpleCard(context, item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleCard(BuildContext context, HomeUserNotificationListModel item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationDetailPage(notification: item)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            const Icon(Icons.circle, size: 8, color: Color(0xFFFF8A00)), // จุดสถานะ
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}