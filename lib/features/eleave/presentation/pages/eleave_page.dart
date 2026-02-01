import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mb_rmuti_profile_demo/features/eleave/eleave_controller.dart';
import 'package:mb_rmuti_profile_demo/features/eleave/presentation/widgets/leave_card_item.dart';
import 'package:mb_rmuti_profile_demo/core/store/notifier/user_profile_notifier.dart';

class EleavePage extends ConsumerWidget {
  const EleavePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ดึง username จาก Global State
    final profile = ref.watch(userProfileProvider);
    final username = profile.username ?? '';
    
    // เรียกใช้ FutureProvider
    final leaveRightsAsync = ref.watch(leaveRightsProvider(username));

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('สิทธิ์การลาของคุณ', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: leaveRightsAsync.when(
        data: (list) => list.isEmpty 
          ? const Center(child: Text('ไม่พบข้อมูลการลา'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              itemBuilder: (context, index) => LeaveCardItem(item: list[index]),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('เกิดข้อผิดพลาด: $err')),
      ),
      //bottomNavigationBar: _buildActionBottom(context),
    );
  }

  Widget _buildActionBottom(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE67E22), // สีส้ม RMUTI
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: () => _launchURL(),
        child: const Text('เข้าสู่ระบบการลาเพื่อทำรายการ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Future<void> _launchURL() async {
    /*
    const url = 'https://mis.rmuti.ac.th/services-authen/auth?url=https://staff.rmuti.ac.th/elv/public/auth/serviceAuthen&tag=elv_rmuti';
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
    */
  }
}