import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import 'package:packs/models/CompanyModel.dart';

class MateDetailCard extends StatelessWidget {
  String? image;
  String? name;
  String? gender;
  String? age;
  MateDetailCard({this.image, this.name, this.gender, this.age});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, PXSpacing.spacingM),
      padding: EdgeInsets.all(PXSpacing.spacingM),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: PXColor.white,
        border: Border.all(color: PXColor.lightGrey),
        borderRadius: BorderRadius.circular(PXBorderRadius.radiusM),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(PXBorderRadius.radiusXXL),
            child:
                Image.network(image!, height: 65, width: 65, fit: BoxFit.cover),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name!,
                style: PXTextStyle.styleLBold,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset(
                    PXImages.cake,
                    height: 12,
                    width: 12,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Age: ' + age!,
                    style: PXTextStyle.styleMRegular,
                  )
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    PXImages.gender,
                    height: 12,
                    width: 12,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Gender: ' + gender!,
                    style: PXTextStyle.styleMRegular,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
