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
