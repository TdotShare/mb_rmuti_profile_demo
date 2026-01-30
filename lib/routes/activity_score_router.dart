import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/activity_score/presentation/pages/activity_score_page.dart';

class ActivityScoreRouters {
  static const String activityScoreFirst = '/activity-score';
}


class ActivityScoreRouter {
  static final Map<String, WidgetBuilder> routes = {
    ActivityScoreRouters.activityScoreFirst : (_) => const ActivityScorePage(),
  };
}
