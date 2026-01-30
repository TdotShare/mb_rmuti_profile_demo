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
    return Container(
      margin: const EdgeInsets.only(bottom: 2), // ระยะห่างระหว่างรายการ
      child: Card(
        color: Colors.white,
        elevation: 0.5, // เงาน้อยๆ ให้พอดูมีมิติ
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // มุมมนแบบทันสมัย
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          
          // ส่วน Icon ด้านซ้าย
          leading: icon != null
              ? Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1), // พื้นหลังไอคอนจางๆ
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                )
              : null,

          // ส่วนของชื่อเมนู (ปรับให้จัดวางตรงกลางซ้ายตามมาตรฐาน ListTile)
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),

          // ส่วนลูกศรด้านขวา (Trailing)
          trailing: trailing ?? const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.grey,
          ),
          
          onTap: onTap,
        ),
      ),
    );
  }
}