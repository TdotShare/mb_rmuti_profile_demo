import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/features/department_student/data/models/student_mock_data.dart';
import 'package:mb_rmuti_profile_demo/features/department_student/presentation/pages/student_list_page.dart';

class DepartmentStudentPage extends ConsumerStatefulWidget {
  const DepartmentStudentPage({super.key});

  @override
  _DepartmentStudentPageState createState() => _DepartmentStudentPageState();
}

class _DepartmentStudentPageState extends ConsumerState<DepartmentStudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0,
        title: const Text('จัดการกลุ่มนักศึกษา', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: mockGroupCodes.length,
        itemBuilder: (context, index) {
          final group = mockGroupCodes[index];
          return _buildGroupItem(group.groupCode);
        },
      ),
    );
  }

  Widget _buildGroupItem(String code) {
    // กรองหาจำนวนนักศึกษาในกลุ่มนี้มาโชว์ที่หน้าแรกเลย
    final studentCount = mockStudents.where((s) => s.studentGroupCode == code).length;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), shape: BoxShape.circle),
          child: const Icon(Icons.class_, color: Colors.orange),
        ),
        title: Text('กลุ่มเรียน: $code', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('นักศึกษาในความดูแล: $studentCount คน'),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentListPage(groupCode: code)),
          );
        },
      ),
    );
  }
}