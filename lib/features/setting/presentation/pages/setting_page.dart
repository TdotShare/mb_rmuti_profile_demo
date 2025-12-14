// SettingPage.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/core/store/notifier/user_profile_notifier.dart';
import 'package:mb_rmuti_profile_demo/features/setting/presentation/widgets/setting_item_label_widget.dart';
import 'package:mb_rmuti_profile_demo/features/setting/presentation/widgets/setting_profile_header_card_widget.dart';
import 'package:mb_rmuti_profile_demo/features/setting/setting_controller.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({ Key? key }) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {

  @override
  Widget build(BuildContext context) {

    final _controller = ref.read(settingControllerProvider);
    final profile = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white70,
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
            SettingProfileHeaderCard(
              voidBtnSelectPhoto: () => _controller.onSelectPhoto(),
              firstName: profile.firstNameTh,
              lastName: profile.lastNameTh,
              facName:  profile.facultyNameTh,
              pictureBase64: profile.pictureBase64,
            ),

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
                    onTap: () {
                      _controller.onLogout(context);
                    },
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