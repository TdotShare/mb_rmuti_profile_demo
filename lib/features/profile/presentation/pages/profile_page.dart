import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:mb_rmuti_profile_demo/core/widgets/barcodeRenderer/barcode_renderer_widget.dart';
import 'package:mb_rmuti_profile_demo/features/profile/presentation/widgets/profile_action_buton_widget.dart';
import 'package:mb_rmuti_profile_demo/features/profile/presentation/widgets/profile_info_card_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ข้อมูลที่ใช้สร้าง Barcode/QRCode (สมมติว่าเป็นรหัสนักศึกษา)
  final String studentId = '651234567890';
  final double cardSize = 250.0; // กำหนดขนาดสำหรับ QRCode/Barcode Card

  // ----------------------------------------------------------------------
  // ⭐️ เมธอด _buildBarcodeWidget ถูกลบไปแล้ว ⭐️
  // ----------------------------------------------------------------------

  // ----------------------------------------------------------------------
  // 1. เมธอดสำหรับแสดง QR Code Popup
  // ----------------------------------------------------------------------
  void _onScanQrCode() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QR Code', textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: BarcodeRendererWidget(
              bc: Barcode.qrCode(),
              data: studentId,
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
  void _onScanBarcode() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Barcode', textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: BarcodeRendererWidget( // ⬅️ เรียกใช้ Widget ใหม่
              bc: Barcode.code128(),
              data: studentId,
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
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
              SizedBox(height: screenHeight * 0.05),

              // 1. ส่วนบัตรนักศึกษา
              const ProfileInfoCardWidget(),

              SizedBox(height: screenHeight * 0.05),

              // 2. ปุ่ม QRCODE และ BARCODE
              SizedBox(
                width: screenWidth * 0.90,
                 child: Column(
                  children: [
                    ProfileActionButonWidget(
                      title: 'QRCODE',
                      icon: Icons.qr_code,
                      onTap: _onScanQrCode, // เรียกใช้เมธอดที่สร้าง QR Code Popup
                    ),
                    const SizedBox(height: 15),
                    ProfileActionButonWidget(
                      title: 'BARCODE',
                      icon: Icons.view_headline_rounded,
                      onTap: _onScanBarcode, // เรียกใช้เมธอดที่สร้าง Barcode Popup
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