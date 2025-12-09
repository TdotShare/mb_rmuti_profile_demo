import 'package:flutter/material.dart';

class SettingItemLabelWidget extends StatelessWidget {

  // 1. ประกาศ Field (คุณสมบัติ) ของ Class โดยใช้ final
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  // ⭐️ เพิ่ม Field สำหรับ IconData ⭐️
  final IconData? icon;
  final Color iconColor; // สามารถกำหนดสีของ Icon ได้

  const SettingItemLabelWidget(
      {
        super.key,
        // 2. ใช้ this.title เพื่อกำหนดค่าให้กับ Field 'title'
        required this.title,
        // 3. เพิ่ม Icon field
        this.icon,
        this.iconColor = Colors.grey, // กำหนดค่าเริ่มต้นเป็นสีเทา
        this.trailing,
        this.onTap
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            width: double.infinity,
            color: Colors.white,
            child: Row(
              // ใช้ MainAxisAlignment.start เพื่อให้ Icon/Title ชิดซ้าย
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ⭐️ 1. ส่วนของ Icon และ Title ⭐️
                Row(
                  children: [
                    // แสดง Icon ถ้ามีการกำหนดค่ามา
                    if (icon != null) ...[
                      Icon(
                        icon,
                        color: iconColor,
                        size: 24, // กำหนดขนาด Icon
                      ),
                      const SizedBox(width: 15), // เว้นระยะห่างระหว่าง Icon กับ Title
                    ],
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Kanit',
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                // ⭐️ 2. ส่วนของ Trailing (เช่น Arrow หรือ Switch) ⭐️
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Divider(height: 0, thickness: 0.5, color: Color(0xFFE0E0E0)),
        ),
      ],
    );
  }
}