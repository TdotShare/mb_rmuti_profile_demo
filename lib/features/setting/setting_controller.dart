import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/features/setting/data/setting_repository.dart';

class SettingController {

  final Ref _ref;
  SettingController(this._ref);

  void onLogout (BuildContext context) {
    final _repository = _ref.read(settingRepositoryProvider);
    _repository.onLogout(context);
  }

  void onSelectPhoto() {
    print("Select Photo function called.");
  }

}

final settingControllerProvider = Provider((ref) => SettingController(ref));