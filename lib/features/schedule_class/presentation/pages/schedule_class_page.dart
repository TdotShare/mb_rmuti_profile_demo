import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/features/schedule_class/presentation/widgets/ScheduleItemCardWidget.dart';

// --- 1. Mockup Model & Data ---
class ScheduleItem {
  final String subjectCode;
  final String subjectName;
  final String time;
  final String room;
  final String teacher;
  final Color color;

  ScheduleItem({
    required this.subjectCode,
    required this.subjectName,
    required this.time,
    required this.room,
    required this.teacher,
    required this.color,
  });
}

final Map<int, List<ScheduleItem>> mockupSchedule = {
  0: [ // จันทร์
    ScheduleItem(subjectCode: '01-411-201', subjectName: 'Mobile Application Development', time: '09:00 - 12:00', room: 'IT-501', teacher: 'ดร.สมชาย ใจดี', color: Colors.amber),
    ScheduleItem(subjectCode: '01-411-205', subjectName: 'Cloud Computing', time: '13:00 - 16:00', room: 'IT-402', teacher: 'อ.สายใจ รักเรียน', color: Colors.blue),
  ],
  1: [ // อังคาร
    ScheduleItem(subjectCode: '01-411-302', subjectName: 'Database Systems', time: '09:00 - 12:00', room: 'Lab-1', teacher: 'ดร.สมศรี มั่งคั่ง', color: Colors.pink),
  ],
  2: [], // พุธ (ว่าง)
  3: [ // พฤหัสบดี
    ScheduleItem(subjectCode: '01-411-101', subjectName: 'General English', time: '10:00 - 12:00', room: 'A-301', teacher: 'Teacher John', color: Colors.orange),
  ],
  4: [ // ศุกร์
    ScheduleItem(subjectCode: '01-411-401', subjectName: 'Senior Project I', time: '09:00 - 16:00', room: 'Meeting Room', teacher: 'ที่ปรึกษาโปรเจกต์', color: Colors.green),
  ],
  5: [], // เสาร์
  6: [], // อาทิตย์
};

// --- 2. Main Page Widget ---
class ScheduleClassPage extends ConsumerStatefulWidget {
  const ScheduleClassPage({Key? key}) : super(key: key);

  @override
  _ScheduleClassPageState createState() => _ScheduleClassPageState();
}

class _ScheduleClassPageState extends ConsumerState<ScheduleClassPage> {
  final List<String> days = ['จันทร์', 'อังคาร', 'พุธ', 'พฤหัสบดี', 'ศุกร์', 'เสาร์', 'อาทิตย์'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA), // สีพื้นหลังเดียวกับหน้า Service Access
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: const Text(
            'ตารางเรียนนักศึกษา',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: const Color(0xFFFF8A00),
            labelColor: const Color(0xFFFF8A00),
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Kanit'),
            tabs: days.map((day) => Tab(text: day)).toList(),
          ),
        ),
        body: TabBarView(
          children: List.generate(7, (index) => _buildDayList(index)),
        ),
      ),
    );
  }

  Widget _buildDayList(int dayIndex) {
    final items = mockupSchedule[dayIndex] ?? [];

    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today_outlined, size: 60, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text('วันนี้ไม่มีตารางเรียน', style: TextStyle(color: Colors.grey[600], fontSize: 16)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ScheduleItemCardWidget(item: items[index]);
      },
    );
  }
}