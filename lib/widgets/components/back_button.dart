import 'package:flutter/cupertino.dart';

class PXBackButton extends StatelessWidget {
  final Color colour;
  final Function onPressed;

  PXBackButton({required this.colour, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(CupertinoIcons.chevron_back, color: colour, size: 30),
    );
  }
}
