import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/features/auth/data/auth_repository.dart';

// -------------------

class AuthController {
  final Ref _ref;

  AuthController(this._ref);


  void onCheckTokenLogin(BuildContext context , String code) async
  {
    final _repository = _ref.read(authRepositoryProvider);
    _repository.onCheckTokenLogin(context , code);
  }

  void onPressedSso(BuildContext context) async {
    final _repository = _ref.read(authRepositoryProvider);
    _repository.onPressedSso(context);
  }
}

// -------------------

final authControllerProvider = Provider((ref) => AuthController(ref));