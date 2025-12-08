// SettingPage.dart

import 'package:flutter/material.dart';

import '../widgets/setting_profile_header_card_widget.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({ Key? key }) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  // ฟังก์ชันสำหรับเลือกรูปภาพ - ยังไม่มี Logic ใดๆ
  void _selectPhoto() {
    // สามารถใส่ Logic สำหรับเปิด Gallery หรือ Camera ได้ที่นี่
    print("Select Photo function called.");
  }

  // Widget สำหรับสร้างรายการตั้งค่าแต่ละบรรทัด
  Widget _buildSettingItem({
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            width: double.infinity,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Kanit',
                    color: Colors.black87,
                  ),
                ),
                if (trailing != null) trailing!, // ⬅️ เพิ่ม ! เพื่อยืนยัน Type
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text(
          'ตั้งค่า',
          style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. ส่วน Header Card (ปรับปรุง Responsiveness ใน setting_profile_header_card.dart แล้ว)
            SettingProfileHeaderCard(voidBtnSelectPhoto: () => _selectPhoto()),

            // 2. รายการตั้งค่า
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSettingItem(
                    title: 'ติดต่อเรา',
                    onTap: () {
                      // Logic สำหรับไปหน้าติดต่อเรา
                    },
                  ),
                  _buildSettingItem(
                    title: 'ข้อกำหนดและเงื่อนไข',
                    onTap: () {
                      // Logic สำหรับไปหน้าข้อกำหนด
                    },
                  ),
                  _buildSettingItem(
                    title: 'เวอร์ชัน 0.0.1',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}