import 'package:annfsu_app/utils/global.colors.dart';
import 'package:flutter/material.dart';

class HomeButtons extends StatelessWidget {
  const HomeButtons(
      {super.key,
      required this.text,
      required this.icon,
      required this.onPressed});
  final String text;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      autofocus: true,
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(GlobalColors.mainColor),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(20)),
        fixedSize: const WidgetStatePropertyAll<Size>(Size(350, 90)),
        textStyle: const WidgetStatePropertyAll<TextStyle>(
            TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
