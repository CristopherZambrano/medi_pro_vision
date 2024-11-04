import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';

Widget listTab(String title, String description, String iconTab,
    {required VoidCallback? onTap}) {
  return Container(
    height: 110,
    decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD0E4F7), width: 2),
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFFFFFFF),
        boxShadow: const [
          BoxShadow(color: Color(0xFFC8E6C9), blurRadius: 6),
        ]),
    child: GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(padding: EdgeInsets.all(8)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                primaryTitle(title),
                Text(
                  description,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(5),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(iconTab),
                fit: BoxFit.contain,
                height: 60,
                width: 60,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget diagnosisTab({
  required String doctor,
  required String diagnosis,
  required String dateDiagnosis,
  required VoidCallback onTap, // Método específico para cada tarjeta
}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: Color(0xFFD0E4F7),
          width: 1.5,
        ),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diagnosis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    doctor,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF388E3C),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    dateDiagnosis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF666666),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
