import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/models/DealModel.dart';

class DealDetailScreenContact extends StatelessWidget {
  final DealModel model;

  DealDetailScreenContact({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PXColor.athensGrey,
      child: Padding(
        padding: const EdgeInsets.all(PXSpacing.spacingXL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Contact', style: PXTextStyle.styleMBold),
            SizedBox(height: PXSpacing.spacingS),
            Text('Got a question or need help? Contact Surf Camp Australia'),
            SizedBox(height: PXSpacing.spacingXL),
            CupertinoButton(
              color: PXColor.darkText,
              disabledColor: PXColor.darkText,
              child: Text('Email'),
              onPressed: () {},
            ),
            SizedBox(height: PXSpacing.spacingS),
            CupertinoButton(
              color: PXColor.darkText,
              disabledColor: PXColor.darkText,
              child: Text('Call'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
