import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/routes/app_router.dart';
import 'package:mb_rmuti_profile_demo/routes/schedule_class_router.dart';

class ScheduleClassController {

  final Ref _ref;

  ScheduleClassController(this._ref);

  //final ScheduleClassRepository _repository = ScheduleClassRepository();

  void btnGoPageScheduleClass(BuildContext context)
  {
    AppRouter.push(context, ScheduleClassRouters.scheduleClassFirst);
  }
}


final scheduleClassControllerProvider = Provider((ref) => ScheduleClassController(ref));