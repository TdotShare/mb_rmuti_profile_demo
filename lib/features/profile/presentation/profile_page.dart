import 'package:flutter/material.dart';

import '../widgets/profile_action_buton_widget.dart';
import '../widgets/profile_info_card_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // (ถ้าคุณต้องการใช้ฟังก์ชันสำหรับปุ่ม QR/Barcode สามารถเพิ่มที่นี่ได้)
  void _onScanQrCode() {
    print("QR Code button pressed");
  }

  void _onScanBarcode() {
    print("Barcode button pressed");
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height; // ⬅️ เพิ่มการเข้าถึง screenHeight

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7), // สีพื้นหลังเทาอ่อน
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
              SizedBox(height: screenHeight * 0.05), // ⬅️ ใช้สัดส่วนแทน 30

              // 1. ส่วนบัตรนักศึกษา
              const ProfileInfoCardWidget(),

              SizedBox(height: screenHeight * 0.10), // ⬅️ ใช้สัดส่วนแทน 60

              // 2. ปุ่ม QRCODE และ BARCODE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    ProfileActionButonWidget(
                      title: 'QRCODE',
                      icon: Icons.qr_code,
                      onTap: _onScanQrCode,
                    ),
                    const SizedBox(height: 15),
                    ProfileActionButonWidget(
                      title: 'BARCODE',
                      icon: Icons.view_headline_rounded, // ใช้ Icon ที่คล้าย Barcode
                      onTap: _onScanBarcode,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}