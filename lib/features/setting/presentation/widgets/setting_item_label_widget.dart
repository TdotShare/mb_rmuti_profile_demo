import 'package:flutter/material.dart';

class SettingItemLabelWidget extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color iconColor;

  const SettingItemLabelWidget({
    super.key,
    required this.title,
    this.icon,
    this.iconColor = Colors.grey,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15), // ให้ Splash effect มนตาม Card
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            if (trailing != null) trailing!,
            if (trailing == null) 
              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}