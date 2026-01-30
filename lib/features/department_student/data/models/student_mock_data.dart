class GroupModel {
  final String groupCode;
  GroupModel({required this.groupCode});
}

class StudentModel {
  final int studentId;
  final String studentCode;
  final String studentEmail;
  final String studentFullName;
  final String studentGroupCode;

  StudentModel({
    required this.studentId,
    required this.studentCode,
    required this.studentEmail,
    required this.studentFullName,
    required this.studentGroupCode,
  });
}

// ✅ ข้อมูลกลุ่มเรียน (แปลงจาก groupCode.json)
final List<GroupModel> mockGroupCodes = [
  GroupModel(groupCode: "CPE.67231"),
  GroupModel(groupCode: "IPD.66241"),
];

// ✅ ข้อมูลนักศึกษา (แปลงจาก student.json)
final List<StudentModel> mockStudents = [
  StudentModel(
    studentId: 1,
    studentCode: "68102110231-3",
    studentEmail: "pimchanok.pn@rmuti.ac.th",
    studentFullName: "พิมพ์ชนก ทดสอบ",
    studentGroupCode: "IPD.66241",
  ),
  StudentModel(
    studentId: 2,
    studentCode: "68102110131-3",
    studentEmail: "thakoon.ch@rmuti.ac.th",
    studentFullName: "ธกูร ทดสอบ",
    studentGroupCode: "IPD.66241",
  ),
  // คุณสามารถเพิ่มข้อมูลเพิ่มที่นี่ได้เลยครับ
];