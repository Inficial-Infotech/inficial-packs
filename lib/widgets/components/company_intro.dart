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
                style: PXTextStyle.styleLBold,
              ),
              if (this.model.address != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Image.asset(PXImages.blackMarker,height: 15,width: 15, color: PXColor.textLight),
                    ),
                    SizedBox(width: PXSpacing.spacingXS),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            '${this.model.address!.city!}, ${this.model.address!.country!}',
                            style: PXTextStyle.styleSRegular.copyWith(color: PXColor.textLight),
                          ),
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
