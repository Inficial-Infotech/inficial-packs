import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';

class PXIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color iconColor;
  final Function() onTap;

  PXIconButton({
    required this.icon,
    this.size = 28,
    this.iconColor = PXColor.darkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          border: Border.all(color: PXColor.lightGrey, width: 1),
          borderRadius: BorderRadius.circular(size / 2),
        ),
        child: Center(
          child: Icon(
            icon,
            size: size / 2,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
