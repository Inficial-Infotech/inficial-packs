import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';

class PXBarButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color iconColor;
  final Function() onTap;

  PXBarButton({
    required this.icon,
    this.size = 36,
    this.iconColor = PXColor.darkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: SizedBox(
        height: size,
        width: size,
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
