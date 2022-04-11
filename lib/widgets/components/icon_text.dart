import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final double size;
  final Color iconColor;
  final Color textColor;
  final FontWeight fontWeight;

  IconText({
    required this.icon,
    required this.text,
    this.size = PXFontSize.sizeS,
    this.iconColor = PXColor.darkText,
    this.textColor = PXColor.darkText,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: size, color: iconColor),
          SizedBox(width: size / 2),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: size,
                color: textColor,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
