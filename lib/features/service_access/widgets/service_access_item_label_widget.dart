// lib/widgets/service_access_item_label_widget.dart

import 'package:flutter/material.dart';

class ServiceAccessItemLabelWidget extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  final IconData? icon;
  final Color iconColor; 

  const ServiceAccessItemLabelWidget({
    super.key,
    required this.title,
    this.icon,
    this.iconColor = Colors.grey, 
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: EdgeInsets.zero, // สามารถลบ margin ของ Card ได้ถ้าต้องการชิดขอบ
      child: ListTile(
        // ⭐️ 1. ใช้ Icon/Leading (ถ้ามี) ⭐️
        leading: icon != null 
            ? Icon(icon, color: iconColor)
            : null,

        // ⭐️ 2. ส่วนของ Title ที่ถูกแก้ไขให้ชิดขวา ⭐️
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end, // จัดเรียง Widget ไปทางขวาสุด
          children: [
            // Text(title) จะอยู่ทางขวา
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ],
        ),

        // ⭐️ 3. ส่วนของ Trailing (เช่น Arrow) ⭐️
        trailing: trailing,
        
        onTap: onTap,
      ),
    );
  }
}