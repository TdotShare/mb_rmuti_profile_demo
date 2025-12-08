import 'package:flutter/material.dart';

class HomeContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // กำหนดความสูงของพื้นที่สีเทาเข้ม (Banner Area)
        final double bannerHeightRatio = 0.40;
        final double bannerHeight = constraints.maxHeight * bannerHeightRatio;

        // กำหนดความสูงของพื้นที่ข้อมูล (Info Card Area)
        const double infoCardHeight = 130.0;
        // ระยะห่างรวมที่ต้องการให้ Info Card อยู่เหนือ Banner (Overlap)
        const double overlapDistance = 15.0; // กำหนดระยะ Overlap ที่ต้องการ

        // คำนวณความสูงที่เหลือสำหรับเนื้อหาด้านล่าง
        // ไม่ได้ใช้ remainingHeight ในโค้ดนี้ แต่เก็บไว้เผื่อ
        // final double remainingHeight = constraints.maxHeight - bannerHeight;

        return Scaffold(
          body: Container(
            color: const Color(0xFFF7F7F7), // พื้นหลังหลัก
            // ใช้ Stack เพื่อให้ Info Card วางซ้อนและ Overlap กับ Banner ได้
            child: Stack(
              clipBehavior:
                  Clip.none, // อนุญาตให้ Widget ออกนอกขอบเขตของ Stack ได้
              children: [
                // 1. พื้นที่ Banner (สีเทาเข้ม) - ต้องอยู่ด้านล่างสุดใน Stack
                Container(
                  width: double.infinity,
                  height: bannerHeight,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFBFB7B7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'side banner',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                    ),
                  ),
                ),

                // 2. เนื้อหาหลักด้านล่าง (เพื่อรองรับพื้นที่ที่เหลือ)
                Positioned(
                  top: bannerHeight,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // ******* พื้นที่ว่างสำหรับ Info Card ที่ Overlap *******
                        SizedBox(height: infoCardHeight - overlapDistance),

                        // 3. เนื้อหาอื่น ๆ ด้านล่าง
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 29.0),
                          child: Container(
                            height: 100,
                            color: Colors.blueGrey[100],
                            alignment: Alignment.center,
                            child: const Text('พื้นที่เนื้อหาด้านล่าง'),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // 4. พื้นที่สำหรับ Info Card (สีเทาอ่อน) - ต้องอยู่ด้านบน
                Positioned(
                  top: bannerHeight - overlapDistance, // เลื่อนขึ้นไป Overlap
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 29),
                    child: Container(
                      width: double.infinity, // เต็มความกว้าง
                      height: infoCardHeight, // ความสูงยังคงที่ (103)
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ข้อความซ้าย
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'สวัสดีคุณ รัฐสรณ์',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'คณะวิทยาศาสตร์และศิลปศาสตร์',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 4),
                              ElevatedButton(
                                onPressed: () {
                                  print("ดูบริการที่เข้าถึงได้ถูกกด");
                                },
                                child: const Text('ดูบริการที่เข้าถึงได้'),
                              )
                            ],
                          ),

                          // รูปภาพโปรไฟล์ขวา (ส่วนที่แก้ไข)
                          Container(
                            width: 75,
                            height: 75,
                            // ไม่ต้องมี decoration: BoxDecoration(...)
                            child: ClipOval(
                              // ใช้ ClipOval ในการตัดรูปภาพให้เป็นวงกลม
                              child: Image.asset(
                                'assets/item/people.png',
                                fit: BoxFit.cover, // สำคัญ: ใช้ BoxFit.cover เพื่อให้ภาพเต็มพื้นที่ 84x84
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
