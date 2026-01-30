import 'package:flutter/material.dart';

class ProfileActionButonWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const ProfileActionButonWidget({
    super.key, 
    required this.title, 
    required this.icon, 
    required this.onTap,
    this.color = const Color(0xFFFF8A00),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color, fontFamily: 'Kanit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}