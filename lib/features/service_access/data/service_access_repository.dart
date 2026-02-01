import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // **1. เพิ่ม Riverpod**
import 'package:mb_rmuti_profile_demo/routes/activity_score_router.dart';
import 'package:mb_rmuti_profile_demo/routes/department_student_router.dart';
import 'package:mb_rmuti_profile_demo/routes/eleave_router.dart';
import 'package:mb_rmuti_profile_demo/routes/schedule_class_router.dart';

class ServiceAccessRepository {
  final Ref _ref;
  ServiceAccessRepository(this._ref);

  void onPressedGoToScheduleClass(BuildContext context) async {
    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamed(ScheduleClassRouters.scheduleClassFirst);
  }

  void onPressedGoToActivityScore(BuildContext context) async {
    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamed(ActivityScoreRouters.activityScoreFirst);
  }

  void onPressedGoToDepartmentStudent(BuildContext context) async {
    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamed(DepartmentStudentRouters.departmentStudentFirst);
  }

  void onPressedGotoEleave(BuildContext context) async {
    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamed(EleaveRouters.eleaveFirst);
  }
}

final serviceAccessRepositoryProvider = Provider(
  (ref) => ServiceAccessRepository(ref),
);
