import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/department_student/data/models/student_mock_data.dart';


class StudentListPage extends StatelessWidget {
  final String groupCode;
  const StudentListPage({super.key, required this.groupCode});

  @override
  Widget build(BuildContext context) {
    // ✅ Logic กรองข้อมูลจาก Mock Data ตรงๆ
    final filteredList = mockStudents.where((s) => s.studentGroupCode == groupCode).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('กลุ่ม $groupCode', style: const TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          _buildHeaderInfo(filteredList.length),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: filteredList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) => StudentCardWidget(student: filteredList[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderInfo(int count) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      color: Colors.blueGrey.withOpacity(0.05),
      child: Text('รายชื่อทั้งหมด ($count คน)', style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
    );
  }
}

// ✅ แยก Widget ออกมาเพื่อความคลีน (ตามข้อ 6)
class StudentCardWidget extends StatelessWidget {
  final StudentModel student;
  const StudentCardWidget({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.orange.shade50,
            child: Text(student.studentFullName[0], style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(student.studentFullName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text('รหัส: ${student.studentCode}', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                Text(student.studentEmail, style: const TextStyle(color: Colors.blue, fontSize: 12, decoration: TextDecoration.underline)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}