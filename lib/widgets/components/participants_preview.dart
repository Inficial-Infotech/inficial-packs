import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';

const int maxImagesShown = 4;
const double imageSize = 28;

class ParticipantsPreview extends StatelessWidget {
  // TODO: Convert to List<URL> if possible
  final List<String> imageURLs;

  ParticipantsPreview({required this.imageURLs});

  @override
  Widget build(BuildContext context) {
    final itemsShown = min(maxImagesShown, imageURLs.length);

    return Container(
      height: imageSize,
      width: imageSize / 2 + (itemsShown * imageSize / 2),
      child: Stack(
        children: [
          for (var i = 0; i <= itemsShown - 1; i++)
            Positioned(
              left: (i * imageSize / 2),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: PXColor.athensGrey, width: 1),
                  borderRadius: BorderRadius.circular(imageSize / 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(imageSize / 2),
                  child: Image.network(
                    imageURLs[i],
                    height: imageSize - 2, // Subtract border
                    width: imageSize - 2, // Subtract border
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          if (imageURLs.length > maxImagesShown)
            Positioned(
              right: 0,
              child: Container(
                height: imageSize,
                width: imageSize,
                decoration: BoxDecoration(
                  color: PXColor.lightGrey,
                  border: Border.all(color: PXColor.athensGrey, width: 1),
                  borderRadius: BorderRadius.circular(imageSize / 2),
                ),
                child: Center(
                  child: Text(
                    '+${imageURLs.length - maxImagesShown + 1}',
                    style: TextStyle(
                      fontSize: PXFontSize.sizeXS,
                      color: PXColor.textLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
