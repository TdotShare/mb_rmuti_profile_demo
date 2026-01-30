import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/features/service_access/presentation/widgets/service_access_item_label_widget.dart';
import 'package:mb_rmuti_profile_demo/features/service_access/service_access_controller.dart';

class ServiceAccessPage extends ConsumerStatefulWidget {
  const ServiceAccessPage({super.key});

  @override
  _ServiceAccessPageState createState() => _ServiceAccessPageState();
}

class _ServiceAccessPageState extends ConsumerState<ServiceAccessPage> {
  @override
  Widget build(BuildContext context) {
    final _serviceAccessController = ref.read(serviceAccessControllerProvider);

    return Scaffold(
      // เปลี่ยนจาก white70 เป็นสีเทาอ่อนแบบ Modern เพื่อให้ Card สีขาวดูเด่นขึ้น
      backgroundColor: const Color(0xFFF5F7FA), 
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0, // ลบเงาออกเพื่อให้ดูแบนราบทันสมัย
        scrolledUnderElevation: 0, // ป้องกันสีเปลี่ยนเวลาเลื่อนหน้าจอ
        title: const Text(
          'บริการทั้งหมด',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        // เพิ่มปุ่มย้อนกลับให้ชัดเจน (เนื่องจากเราเปิดแบบ Full Screen)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // เพิ่มฟีลลิ่งการไถหน้าจอแบบลื่นๆ
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              ServiceAccessItemLabelWidget(
                title: "ตารางเรียนนักศึกษา",
                icon: Icons.calendar_month_rounded,
                iconColor: const Color(0xFFFF8A00), // ใช้สีส้ม RMUTI
                onTap: () => _serviceAccessController.onPressedGoToScheduleClass(context),
              ),
              const SizedBox(height: 8),
              ServiceAccessItemLabelWidget(
                title: "คะแนนกิจกรรม",
                icon: Icons.stars_rounded,
                iconColor: Colors.amber,
                onTap: () {
                  // TODO: เพิ่ม logic
                },
              ),
              const SizedBox(height: 8),
              ServiceAccessItemLabelWidget(
                title: "รายชื่อนักศึกษาในสังกัด",
                icon: Icons.people_alt_rounded,
                iconColor: Colors.blueAccent,
                onTap: () {
                  // TODO: เพิ่ม logic
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}