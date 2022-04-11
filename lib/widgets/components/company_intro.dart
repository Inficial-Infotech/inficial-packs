import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import 'package:packs/models/CompanyModel.dart';

class CompanyIntro extends StatelessWidget {
  final CompanyModel model;

  CompanyIntro({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          if (this.model.logoURL != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image.network(
                this.model.logoURL!,
                height: 32,
                width: 32,
                fit: BoxFit.cover,
              ),
            ),
          SizedBox(width: PXSpacing.spacingS),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO: Handle nullable
              Text(
                this.model.name!,
                style: PXTextStyle.styleMRegular,
              ),
              if (this.model.address != null)
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: PXFontSize.sizeXS,
                      color: PXColor.textLight,
                    ),
                    SizedBox(width: PXSpacing.spacingXS),
                    Row(
                      children: [
                        Text(
                          '${this.model.address!.city!}, ${this.model.address!.country!}',
                          style: PXTextStyle.styleXSRegular,
                        ),
                      ],
                    ),
                  ],
                )
            ],
          )
        ],
      ),
    );
  }
}
