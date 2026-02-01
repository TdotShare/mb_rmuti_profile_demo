import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/eleave/presentation/pages/eleave_page.dart';

class EleaveRouters {
  static const String eleaveFirst = '/eleave';
}


class EleaveRouter {
  static final Map<String, WidgetBuilder> routes = {
    EleaveRouters.eleaveFirst : (_) => const EleavePage(),
  };
}
