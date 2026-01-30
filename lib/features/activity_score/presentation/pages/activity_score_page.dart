import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/features/activity_score/data/models/activity_type.dart';
import 'package:mb_rmuti_profile_demo/features/activity_score/presentation/widgets/activity_card_widget.dart';

class ActivityScorePage extends ConsumerStatefulWidget {
  const ActivityScorePage({Key? key}) : super(key: key);

  @override
  _ActivityScorePageState createState() => _ActivityScorePageState();
}

class _ActivityScorePageState extends ConsumerState<ActivityScorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // ใช้โทนสีเดียวกับหน้าอื่นที่เราทำ
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'คะแนนกิจกรรม',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockupActivityData.length,
        itemBuilder: (context, index) {
          return ActivityCardWidget(data: mockupActivityData[index]);
        },
      ),
    );
  }
}