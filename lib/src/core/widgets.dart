import 'package:flutter/material.dart';

class DisplayButtonWidget extends StatelessWidget {
  const DisplayButtonWidget({
    super.key,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.onPressed,
  });

  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        textStyle: const TextStyle(fontSize: 24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Text(text),
      ),
    );
  }
}
