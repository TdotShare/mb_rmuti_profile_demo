import 'package:flutter/material.dart';
import 'package:mb_rmuti_profile_demo/features/service_access/widgets/service_access_item_label_widget.dart';


class ServiceAccessPage extends StatefulWidget {
  const ServiceAccessPage({super.key});

  @override
  State<ServiceAccessPage> createState() => _ServiceAccessPage();
}

class _ServiceAccessPage extends State<ServiceAccessPage> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: const Text(
          'บริการทั้งหมด',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
                ServiceAccessItemLabelWidget(
                  title: "ตารางเรียนนักศึกษา",
                ),
                ServiceAccessItemLabelWidget(
                  title: "คะแนนกิจกรรม",
                ),
                ServiceAccessItemLabelWidget(
                  title: "รายชื่อนักศึกษาในสังกัด",
                )
            ],
          ),
        ),
      ),
    );
  }
}