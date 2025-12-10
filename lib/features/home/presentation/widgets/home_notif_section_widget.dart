// lib/features/home/presentation/widgets/home_notif_section_widget.dart

import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/home/data/models/home_user_notification_list_model.dart';

class HomeNotifSectionWidget extends StatelessWidget {
  
  final List<HomeUserNotificationListModel> notifications; 

  const HomeNotifSectionWidget({
    super.key,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    // **สำคัญ:** ลบ Positioned() ออก และใช้ Padding ครอบ
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text( 
            'การแจ้งเตือนจากระบบ !',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          
          // Expanded จะใช้พื้นที่ที่เหลือทั้งหมดใน Positioned.fill
          Expanded( 
            child: ListView.builder(
              // ป้องกันไม่ให้ ListView มี Padding ซ้ำกับ SafeArea
              padding: EdgeInsets.zero, 
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.notifications),
                    title: Text(notification.title),
                    subtitle: Text(notification.detail),
                    onTap: () {
                      // Action เมื่อคลิก
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}