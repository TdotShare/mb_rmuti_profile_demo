import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart'; // ⬅️ ต้องใช้ barcode_widget

class BarcodeRendererWidget extends StatelessWidget {

  final Barcode bc; // Barcode Type (e.g., Barcode.qrCode())
  final String data; // ข้อมูลที่จะนำไปสร้าง Barcode/QR Code
  final String type; // ใช้สำหรับกำหนดความสูง 'QRCODE' หรือ 'BARCODE'
  final double cardSize; // ขนาดความกว้างหลัก (เดิมคือ widthBarcode)

  const BarcodeRendererWidget({
    super.key,
    required this.bc,
    required this.data,
    required this.type,
    required this.cardSize, // เปลี่ยนชื่อให้ตรงกับที่ใช้ใน ProfilePage
  });

  // ⭐️ การคำนวณต้องทำใน getter หรือทำใน build method ⭐️
  double get _widgetHeight {
    // QR Code เป็นสี่เหลี่ยมจัตุรัส, Barcode 1D เป็นสี่เหลี่ยมผืนผ้า
    return type == 'QRCODE' ? cardSize : cardSize / 2;
  }

  @override
  Widget build(BuildContext context) {

    final double widgetHeight = _widgetHeight; // เรียกใช้ getter ที่ถูกต้อง

    return Container(
      width: cardSize, // ใช้ cardSize เป็นความกว้างหลัก
      height: widgetHeight + 20, // เพิ่มความสูงเผื่อขอบ Padding
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
            // (Note: style ถูกใช้สำหรับข้อความด้านล่าง Barcode/QR Code.
            // สำหรับ QR Code อาจไม่มีผล)
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}