import 'package:flutter/material.dart';

class SettingItemLabelWidget  extends StatelessWidget {

  // 1. ประกาศ Field (คุณสมบัติ) ของ Class โดยใช้ final
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingItemLabelWidget(
      {
        super.key,
        // 2. ใช้ this.title เพื่อกำหนดค่าให้กับ Field 'title'
        required this.title,
        // 3. ใช้ this.trailing และ this.onTap
        this.trailing,
        this.onTap
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap, // build method สามารถเข้าถึง Field 'onTap' ได้แล้ว
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            width: double.infinity,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title, // build method สามารถเข้าถึง Field 'title' ได้แล้ว
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Kanit',
                    color: Colors.black87,
                  ),
                ),
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