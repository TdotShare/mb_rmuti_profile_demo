// **Widget สำหรับปุ่ม QRCODE/BARCODE**
import 'package:flutter/material.dart';

class ProfileActionButonWidget extends StatelessWidget {

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ProfileActionButonWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 24),
        label: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Kanit',
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF8A00), // สีส้ม
          foregroundColor: Colors.white, // สีข้อความ/ไอคอน
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}