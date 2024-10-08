import 'package:flutter/material.dart';
import 'package:on_u_admin/global.dart';

Widget Columns(BuildContext context, String title, String content) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
      SizedBox(height: 5),
      Text(content, style: TextStyle(fontSize: 15, color: mainColor, fontWeight: FontWeight.w500),),
    ],
  );
}