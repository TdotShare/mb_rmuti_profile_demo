// SettingPage.dart

import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/setting/presentation/widgets/setting_item_label_widget.dart';
import 'package:mb_rmuti_profile_demo/features/setting/presentation/widgets/setting_profile_header_card_widget.dart';
import 'package:mb_rmuti_profile_demo/routes/auth_router.dart';

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

  void _onLogout() {
    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
      AuthRoutes.authToken, // Route ที่ต้องการไป (หน้า Login)
          (Route<dynamic> route) => false, // ล้าง Stack ทั้งหมด
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
                  SettingItemLabelWidget(
                    title: 'ติดต่อเรา',
                    icon: Icons.contact_mail,
                    onTap: () {
                      // Logic สำหรับไปหน้าติดต่อเรา
                    },
                  ),
                  SettingItemLabelWidget(
                    title: 'ข้อกำหนดและเงื่อนไข',
                    icon: Icons.rule,
                    onTap: () {
                      // Logic สำหรับไปหน้าข้อกำหนด
                    },
                  ),
                  SettingItemLabelWidget(
                    title: 'เวอร์ชัน 0.0.1',
                    icon: Icons.verified,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

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
                  SettingItemLabelWidget(
                    title: 'ออกจากระบบ',
                    icon: Icons.logout,
                    iconColor: Colors.red,
                    onTap: _onLogout,
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