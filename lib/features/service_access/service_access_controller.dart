import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/features/schedule_class/schedule_class_controller.dart';


// -------------------

class ServiceAccessController {
  final Ref _ref;

  ServiceAccessController(this._ref);

  void onPressedGoToScheduleClass(BuildContext context) async {
    final _repository = _ref.read(scheduleClassControllerProvider);
    _repository.btnGoPageScheduleClass(context);
  }
}

// -------------------

final serviceAccessControllerProvider = Provider((ref) => ServiceAccessController(ref));