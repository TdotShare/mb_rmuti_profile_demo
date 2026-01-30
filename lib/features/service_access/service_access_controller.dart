import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/features/service_access/data/service_access_repository.dart';

// -------------------

class ServiceAccessController {
  final Ref _ref;

  ServiceAccessController(this._ref);

  void onPressedGoToScheduleClass(BuildContext context) async {
    final _repository = _ref.read(serviceAccessRepositoryProvider);
    _repository.onPressedGoToScheduleClass(context);
  }

  void onPressedGoToActivityScore(BuildContext context) async {
    final _repository = _ref.read(serviceAccessRepositoryProvider);
    _repository.onPressedGoToActivityScore(context);
  }

  void onPressedGoToDepartmentStudent(BuildContext context) async {
    final _repository = _ref.read(serviceAccessRepositoryProvider);
    _repository.onPressedGoToDepartmentStudent(context);
  }
}

// -------------------

final serviceAccessControllerProvider = Provider(
  (ref) => ServiceAccessController(ref),
);
