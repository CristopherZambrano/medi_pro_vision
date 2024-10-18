import 'package:flutter/material.dart';

Widget primaryButton({
  required String buttonText,
  IconData? icon,
  required VoidCallback onPressed,
}) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      backgroundColor: const Color(0xFF007BFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      minimumSize: const Size(300, 48),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
        ],
        Text(
          buttonText,
          style: const TextStyle(color: Color(0xFFFFFFFF)),
        ),
      ],
    ),
  );
}

Widget secondaryButton({
  required String buttonText,
  IconData? icon,
  required VoidCallback onPressed,
}) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      backgroundColor: const Color(0xFF4CAF50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      minimumSize: const Size(300, 48),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            color: const Color(0xFFFFFFFF),
          ),
          const SizedBox(width: 8),
        ],
        Text(
          buttonText,
          style: const TextStyle(color: Color(0xFFFFFFFF)),
        ),
      ],
    ),
  );
}
