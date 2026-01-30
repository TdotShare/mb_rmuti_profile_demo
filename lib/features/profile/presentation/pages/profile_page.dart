import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/core/store/notifier/user_profile_notifier.dart';
import 'package:mb_rmuti_profile_demo/core/widgets/barcodeRenderer/barcode_renderer_widget.dart';
import 'package:mb_rmuti_profile_demo/features/profile/presentation/widgets/profile_action_buton_widget.dart';
import 'package:mb_rmuti_profile_demo/features/profile/presentation/widgets/profile_info_card_widget.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final double cardSize = 250.0; // กำหนดขนาดสำหรับ QRCode/Barcode Card

  // ----------------------------------------------------------------------
  // ⭐️ เมธอด _buildBarcodeWidget ถูกลบไปแล้ว ⭐️
  // ----------------------------------------------------------------------

  // ----------------------------------------------------------------------
  // 1. เมธอดสำหรับแสดง QR Code Popup
  // ----------------------------------------------------------------------
  void _onScanQrCode(String codeId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QR Code', textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: BarcodeRendererWidget(
              bc: Barcode.qrCode(),
              data: codeId,
              type: 'QRCODE',
              cardSize: cardSize,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('ปิด'),
            ),
          ],
        );
      },
    );
  }

  // ----------------------------------------------------------------------
  // 2. เมธอดสำหรับแสดง Barcode Popup
  // ----------------------------------------------------------------------
  void _onScanBarcode(String codeId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Barcode', textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: BarcodeRendererWidget(
              // ⬅️ เรียกใช้ Widget ใหม่
              bc: Barcode.code128(),
              data: codeId,
              type: 'BARCODE',
              cardSize: cardSize, // ส่งค่า cardSize เข้าไป
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('ปิด'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(userProfileProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    if (profile == null)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      extendBodyBehindAppBar: true, // ให้พื้นหลังทะลุไปถึง AppBar
      appBar: AppBar(
        title: const Text(
          'โปรไฟล์นักศึกษา',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 1. Background Gradient
          Container(
            height: 300,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFF8A00), Colors.white], // สีส้ม RMUTI
              ),
            ),
          ),
          // 2. Content
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: kToolbarHeight + 60),
                // ส่วนบัตรนักศึกษา
                ProfileInfoCardWidget(
                  codeId: profile.code?.toString(),
                  firstName: profile.firstNameTh,
                  lastName: profile.lastNameTh,
                  facName: profile.facultyNameTh,
                  pictureUrl: profile.picture,
                  pictureBase64: profile.pictureBase64,
                ),

                const SizedBox(height: 40),

                // ส่วนปุ่ม Action
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "บริการดิจิทัล",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: ProfileActionButonWidget(
                              title: 'QR Code',
                              icon: Icons.qr_code_2_rounded,
                              onTap: () => _onScanQrCode("${profile.code ?? ""}"),
                              color: const Color(0xFFFF8A00),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: ProfileActionButonWidget(
                              title: 'Barcode',
                              icon: Icons.view_headline_rounded,
                              onTap: () => _onScanBarcode("${profile.code ?? ""}"),
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
