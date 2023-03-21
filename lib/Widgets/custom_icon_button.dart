import 'package:firebase/Styles/customColors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon buttonIcon;
  final Color textColor;
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.buttonIcon,
    this.textColor = CustomColors.iconButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.orange,
      color: Colors.white,
      onPressed: onPressed,
      icon: buttonIcon,
    );
  }
}
