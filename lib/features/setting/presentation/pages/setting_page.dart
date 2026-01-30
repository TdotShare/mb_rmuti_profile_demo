import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/core/store/notifier/user_profile_notifier.dart';
import 'package:mb_rmuti_profile_demo/features/setting/presentation/widgets/setting_item_label_widget.dart';
import 'package:mb_rmuti_profile_demo/features/setting/presentation/widgets/setting_profile_header_card_widget.dart';
import 'package:mb_rmuti_profile_demo/features/setting/setting_controller.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final _controller = ref.read(settingControllerProvider);
    final profile = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // สีพื้นหลังเทาอ่อนมากๆ ให้ Card ดูเด่น
      appBar: AppBar(
        title: const Text('ตั้งค่า', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // ส่วนหัวโปรไฟล์
            SettingProfileHeaderCard(
              voidBtnSelectPhoto: () => _controller.onSelectPhoto(context),
              firstName: profile?.firstNameTh,
              lastName: profile?.lastNameTh,
              facName: profile?.facultyNameTh,
              pictureUrl: profile?.picture,
              pictureBase64: profile?.pictureBase64,
            ),

            const SizedBox(height: 10),

            _buildSectionTitle("ช่วยเหลือและอื่นๆ"),
            _buildGroupContainer([
              SettingItemLabelWidget(
                title: 'ศูนย์ช่วยเหลือ',
                icon: Icons.help_outline_rounded,
                iconColor: Colors.green,
                onTap: () {},
              ),
              SettingItemLabelWidget(
                title: 'ข้อกำหนดและเงื่อนไข',
                icon: Icons.description_outlined,
                iconColor: Colors.purple,
                onTap: () {},
              ),
              SettingItemLabelWidget(
                title: 'เวอร์ชันแอป',
                icon: Icons.info_outline_rounded,
                trailing: const Text("0.0.1", style: TextStyle(color: Colors.grey)),
                onTap: () {},
              ),
            ]),

            const SizedBox(height: 20),

            // ปุ่มออกจากระบบ (ทำเป็น Card แยกสีขาว)
            _buildGroupContainer([
              SettingItemLabelWidget(
                title: 'ออกจากระบบ',
                icon: Icons.logout_rounded,
                iconColor: Colors.red,
                onTap: () => _controller.onLogout(context),
              ),
            ]),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Helper สร้างหัวข้อกลุ่ม
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
    );
  }

  // Helper สร้างกล่องกลุ่มเมนู
  Widget _buildGroupContainer(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(children: children),
    );
  }
}