import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/department_student/presentation/pages/department_student_page.dart';

class DepartmentStudentRouters {
  static const String departmentStudentFirst = '/department-student';
}


class DepartmentStudentRouter {
  static final Map<String, WidgetBuilder> routes = {
    DepartmentStudentRouters.departmentStudentFirst : (_) => const DepartmentStudentPage(),
  };
}
