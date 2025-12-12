import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/core/store/notifier/user_profile_notifier.dart';
import 'package:mb_rmuti_profile_demo/core/widgets/barcodeRenderer/barcode_renderer_widget.dart';
import 'package:mb_rmuti_profile_demo/features/profile/presentation/widgets/profile_action_buton_widget.dart';
import 'package:mb_rmuti_profile_demo/features/profile/presentation/widgets/profile_info_card_widget.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

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
            child: BarcodeRendererWidget( // ⬅️ เรียกใช้ Widget ใหม่
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

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: const Text(
          'โปรไฟล์',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),
              // 1. ส่วนบัตรนักศึกษา
              ProfileInfoCardWidget(
                codeId: profile.code?.toString(),
                firstName: profile.firstNameTh,
                lastName: profile.lastNameTh,
                facName: profile.facultyNameTh,
                pictureUrl: profile.picture,
                pictureBase64: profile.pictureBase64,
              ),

              SizedBox(height: screenHeight * 0.05),

              // 2. ปุ่ม QRCODE และ BARCODE
              SizedBox(
                width: screenWidth * 0.90,
                 child: Column(
                  children: [
                    ProfileActionButonWidget(
                      title: 'QRCODE',
                      icon: Icons.qr_code,
                      onTap: () {
                        _onScanQrCode(profile.code.toString() ?? "");
                      },
                    ),
                    const SizedBox(height: 15),
                    ProfileActionButonWidget(
                      title: 'BARCODE',
                      icon: Icons.view_headline_rounded,
                      onTap: () {
                        _onScanBarcode(profile.code.toString() ?? "");
                      }
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}