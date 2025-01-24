import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_tes2/app/components/mahas_colors.dart';

enum LoginButtonType { google, apple, email }

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final LoginButtonType type;

  const LoginButton({
    super.key,
    required this.onPressed,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    String title = "";
    IconData icon = FontAwesomeIcons.google;
    Color backgroundColor = MahasColors.primary;

    switch (type) {
      case LoginButtonType.google:
        title = "Sign in with Google";
        icon = FontAwesomeIcons.google;
        backgroundColor = MahasColors.primary;
        break;
      case LoginButtonType.apple:
        title = "Sign in with Apple";
        icon = FontAwesomeIcons.apple;
        backgroundColor = MahasColors.dark;
        break;
      case LoginButtonType.email:
        title = "Sign in with Email";
        icon = FontAwesomeIcons.envelope;
        backgroundColor = MahasColors.primary;
        break;
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
          ),
          const Padding(padding: EdgeInsets.all(5)),
          Text(
            title,
          ),
        ],
      ),
    );
  }
}
