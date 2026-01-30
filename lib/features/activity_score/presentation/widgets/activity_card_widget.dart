import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/activity_score/data/models/activity_type.dart';

class ActivityCardWidget extends StatelessWidget {
  final ActivityType data;

  const ActivityCardWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPass = data.participationResult == 1;
    final bool hasSummary = data.summaryResults != null && data.summaryResults!.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // มนขึ้นอีกนิดเพื่อความละมุน
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ส่วนหัว: ปรับพื้นหลังตามสถานะ ผ่าน/ไม่ผ่าน จางๆ
          Container(
            decoration: BoxDecoration(
              color: isPass ? Colors.green.withOpacity(0.05) : Colors.orange.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListTile(
              title: Text(
                data.freeTypeName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
              ),
              trailing: isPass 
                ? const Icon(Icons.check_circle_rounded, color: Colors.green, size: 28)
                : const Icon(Icons.info_outline_rounded, color: Colors.orange, size: 28),
            ),
          ),
          
          const Divider(height: 1, color: Colors.black12),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // ใช้ Evenly เพื่อให้ระยะห่างสวยกว่า
              children: [
                if (!hasSummary) 
                  _buildStatItem("กิจกรรมที่ได้", '${data.countActivity}/${data.rAct}', "ครั้ง", Colors.blueGrey),

                _buildStatItem("หน่วยกิตสะสม", '${data.unitActivity}/${data.rUnit}', "หน่วย", const Color(0xFFFF8A00)),
              ],
            ),
          ),

          if (hasSummary) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "สรุปผลแยกตามด้าน (ครั้ง)", 
                style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600, letterSpacing: 0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: data.summaryResults!.map<Widget>((res) {
                  final bool areaPass = res.eachAreaResults == 1;
                  return _buildAreaChip(res, areaPass, data.rAct);
                }).toList(),
              ),
            ),
          ],
          if (!hasSummary) const SizedBox(height: 8),
        ],
      ),
    );
  }

  // สร้าง Stat Item ให้ดูมีมิติ
  Widget _buildStatItem(String label, String value, String unit, Color valueColor) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: valueColor, fontFamily: 'Kanit'),
            children: [
              TextSpan(text: value.split('/')[0]),
              TextSpan(
                text: ' / ${value.split('/')[1]}', 
                style: TextStyle(fontSize: 14, color: Colors.grey.shade400, fontWeight: FontWeight.bold)
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(unit, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ],
    );
  }

  // ปรับแต่ง Chip ให้ดูเหมือนป้ายสถานะ
  Widget _buildAreaChip(dynamic res, bool isPass, String target) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isPass ? Colors.green.withOpacity(0.08) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isPass ? Colors.green.withOpacity(0.2) : Colors.transparent,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            res.categoryShotName, 
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isPass ? Colors.green.shade700 : Colors.blueGrey),
          ),
          const SizedBox(width: 6),
          Text(
            "${res.participateAll} / $target",
            style: TextStyle(fontSize: 11, color: isPass ? Colors.green.shade600 : Colors.grey),
          ),
        ],
      ),
    );
  }
}