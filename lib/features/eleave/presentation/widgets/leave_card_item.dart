import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/eleave/data/models/leave_right_model.dart';

class LeaveCardItem extends StatelessWidget {
  final LeaveRightModel item;
  const LeaveCardItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // กำหนดค่าจาก API
    final double max = (item.leaveRightDayMax ?? 0).toDouble();
    final double remaining = item.userLeaveSumDay ?? 0.0; // ค่าที่ API ส่งมาคือวันคงเหลือ
    
    // คำนวณวันลาที่ใช้ไปแล้วตาม Logic: สิทธิ์สูงสุด - วันคงเหลือ
    final double used = max - remaining;
    
    // คำนวณ % สำหรับ Progress Bar (อ้างอิงจากวันที่ใช้ไป)
    final double percent = max > 0 ? (used / max) : 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.docCategoryName ?? 'การลา',
                style: const TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.blueGrey
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50, 
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text(
                  'คงเหลือ ${remaining.toStringAsFixed(1)} วัน', 
                  style: const TextStyle(
                    color: Colors.green, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 12
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          LinearProgressIndicator(
            value: percent,
            minHeight: 10,
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.grey.shade100,
            // ถ้าใช้ไปเยอะ (เกิน 80%) ให้เปลี่ยนเป็นสีส้ม/แดง เพื่อเตือน
            color: percent > 0.8 ? Colors.deepOrangeAccent : Colors.blueAccent,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ใช้ไปแล้ว ${used.toStringAsFixed(1)} วัน', 
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              Text(
                'จากสิทธิ์ทั้งหมด ${max.toInt()} วัน', 
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
            ],
          )
        ],
      ),
    );
  }
}