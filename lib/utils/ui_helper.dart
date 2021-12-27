import 'package:flutter/material.dart';

//Show Normal TextView
Widget showText({
  required String message,
  double? fontSize,
  String? fontFamily,
  Color? color,
  TextAlign? textAlign,
  FontWeight? fontWeight,
}) {
  return Text(
    message,
    textAlign: textAlign ?? TextAlign.left,
    style: TextStyle(
        color: color,
        fontSize: fontSize ?? 12.0,
        fontWeight: fontWeight ?? FontWeight.w900),
  );
}

//Show Normal TextView
Widget showClickableText({
  required String message,
  required VoidCallback onTap,
  double? fontSize,
  String? fontFamily,
  Color? color,
  TextAlign? textAlign,
  FontWeight? fontWeight,
}) {
  return GestureDetector(
    onTap: onTap,
    child: showText(
      message: message,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}

//Show Icon Button
Widget showIconButton({
  required VoidCallback onPressed,
  required IconData icon,
  Color? color,
}) {
  return IconButton(
    onPressed: onPressed,
    icon: Icon(
      icon,
      color: color,
    ),
  );
}

//Search box
Widget showSearchBar({
  required BuildContext context,
  required String hintText,
  required ValueChanged<String> onChanged,
  VoidCallback? onTap,
  VoidCallback? searchBtnPressed,
}) {
  return SizedBox(
    height: 50,
    child: Card(
      shape: const OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: Colors.grey)),
      child: TextField(
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
          border: InputBorder.none,
        ),
        onChanged: onChanged,
      ),
    ),
  );
}
