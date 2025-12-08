import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart'; // ⬅️ IMPORT 1: นำเข้า BarcodeWidget
import '../widgets/profile_action_buton_widget.dart';
import '../widgets/profile_info_card_widget.dart';

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
  // ⭐️ เมธอดหลักในการสร้าง Barcode/QR Code Widget ⭐️
  // ----------------------------------------------------------------------
  Widget _buildBarcodeWidget({
    required Barcode bc, // ใช้ประเภท Barcode จากไลบรารี
    required String data,
    required String type,
  }) {
    // กำหนดความสูงตามประเภท (QR Code เป็นสี่เหลี่ยม, Barcode 1D เป็นสี่เหลี่ยมผืนผ้า)
    final double widgetHeight = type == 'QRCODE' ? cardSize : cardSize / 2;

    return Container(
      width: cardSize,
      height: widgetHeight + 50, // เพิ่มความสูงเผื่อข้อความด้านล่าง
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Barcode/QR Code ตัวจริง
          BarcodeWidget(
            barcode: bc,
            data: data,
            width: cardSize,
            height: widgetHeight,
            // ปรับสีและความหนาของข้อความ
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          // ข้อความอธิบาย
          Text(
            type == 'QRCODE' ? 'สแกน QR Code นี้' : 'สแกน Barcode นี้',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------------
  // 1. เมธอดสำหรับแสดง QR Code Popup
  // ----------------------------------------------------------------------
  void _onScanQrCode() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('แสดง QR Code นักศึกษา', textAlign: TextAlign.center),
          content: SingleChildScrollView( // ใช้ SingleChildScrollView เผื่อหน้าจอขนาดเล็ก
            child: _buildBarcodeWidget(
              bc: Barcode.qrCode(), // ใช้ Barcode.qrCode()
              data: studentId,
              type: 'QRCODE',
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Popup
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
          title: const Text('แสดง Barcode นักศึกษา', textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: _buildBarcodeWidget(
              bc: Barcode.code128(), // ใช้ Barcode.code128() ซึ่งเป็น Barcode 1D ที่นิยมที่สุด
              data: studentId,
              type: 'BARCODE',
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Popup
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

              SizedBox(height: screenHeight * 0.10),

              // 2. ปุ่ม QRCODE และ BARCODE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}