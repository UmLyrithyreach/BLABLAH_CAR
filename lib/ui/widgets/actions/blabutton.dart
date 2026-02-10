import 'package:flutter/material.dart';

class BlaButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final BlaButtonType type;

  const BlaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.type = BlaButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();

    return SizedBox(
      width: double.infinity,
      height: 40,
      child: MaterialButton(
        onPressed: onPressed,
        color: colors['background'],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: colors['text']),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: colors['text'],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getColors() {
    switch (type) {
      case BlaButtonType.primary:
        return {'background': Color(0xFF00A8E8), 'text': Colors.white};
      case BlaButtonType.secondary:
        return {'background': Colors.grey[300], 'text': Colors.black87};
    }
  }
}

enum BlaButtonType { primary, secondary }
