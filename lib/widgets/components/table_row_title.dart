import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packs/constants/app_constants.dart';

class PXTableRowTitle extends StatelessWidget {
  final String title;
  PXTableRowTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(title, style: PXTextStyle.styleLBold),
          SizedBox(height: PXSpacing.spacingL),
        ],
      ),
    );
  }
}
