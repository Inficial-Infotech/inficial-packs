import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    required this.title,
    required this.colour,
    required this.onPressed,
  });

  final Color colour;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PXColor.white,
        border: Border.all(color: PXColor.athensGrey),
        borderRadius: BorderRadius.circular(PXBorderRadius.radiusM),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: CupertinoButton.filled(
          onPressed: onPressed,
          child: const Text('Continue'),
        ),
      ),
    );
  }
}
