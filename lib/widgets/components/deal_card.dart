import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packs/constants/app_constants.dart';
import 'package:packs/models/AddressModel.dart';
import 'package:packs/models/CompanyModel.dart';
import 'package:packs/models/DealModel.dart';
import 'package:packs/modules/deals/screens/deal_detail_screen.dart';
import 'package:packs/utils/globals.dart' as globals;
import 'package:packs/utils/services/database_manager.dart';
import 'package:packs/widgets/components/company_intro.dart';

class DealCard extends StatefulWidget {
  final DealModel model;

  DealCard({required this.model});

  @override
  _DealCardState createState() => _DealCardState();
}

class _DealCardState extends State<DealCard> {
  final _databaseManager = DatabaseManager();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, PXSpacing.spacingM),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: PXColor.white,
          border: Border.all(color: PXColor.athensGrey),
          borderRadius: BorderRadius.circular(PXBorderRadius.radiusM),
        ),
        child: Column(
          children: [
            // Image
            Stack(
              children: [
                if (widget.model.titleImage != null)
                  Image.network(
                    widget.model.titleImage!,
                    height: 160.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CupertinoButton(
                      child: Icon(
                        globals.currentUserData.savedDeals != null &&
                                globals.currentUserData.savedDeals!
                                    .contains(widget.model.uid)
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: PXColor.darkText,
                      ),
                      onPressed: () {
                        // TODO: Handle nullable
                        if (globals.currentUserData.savedDeals == null) {
                          globals.currentUserData.savedDeals = [];
                        }

                        if (!globals.currentUserData.savedDeals!
                            .contains(widget.model.uid)) {
                          globals.currentUserData.savedDeals!
                              .add(widget.model.uid!);
                        } else {
                          globals.currentUserData.savedDeals!
                              .remove(widget.model.uid!);
                        }

                        setState(() => {
                              _databaseManager.setUserData(),
                            });
                      },
                    ),
                  ),
                )
              ],
            ),
            // Info/Text Box
            Padding(
              padding: EdgeInsets.all(PXSpacing.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: PXSpacing.spacingS),
                  Container(
                    width: double.infinity,
                    child: Text(
                      // TODO: Handle nullable
                      widget.model.name!,
                      style: PXTextStyle.styleLBold,
                    ),
                  ),
                  SizedBox(height: PXSpacing.spacingS),
                  Text(
                    // TODO: Handle nullable
                    '${widget.model.price!.currency} \$${widget.model.price!.value}',
                    style: PXTextStyle.styleLBold,
                  ),
                  SizedBox(height: PXSpacing.spacingXS),
                  // TODO: Handle nullable
                  if (widget.model.price?.priceBeforeDiscount != null)
                    Text(
                      widget.model.price!.priceBeforeDiscount.toString(),
                      style: TextStyle(
                        fontSize: PXFontSize.sizeXS,
                        color: PXColor.textLight,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  SizedBox(height: PXSpacing.spacingM),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // TODO: Should we add the company rating to each deal or
                      // do we just want to add a reference and load from there?
                      //
                      // TODO: Replace with `widget.model.companyBlaBla...`
                      CompanyIntro(
                        model: CompanyModel(
                          logoURL:
                              'https://d1wnwqwep8qkqc.cloudfront.net/uploads/stage/stage_image/41544/optimized_large_thumb_stage.jpg',
                          name: 'Jeep Xplorers',
                          address: AddressModel(
                              city: 'Noosa', country: 'Australias'),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: PXFontSize.headline,
                              color: PXColor.yellow,
                            ),
                            SizedBox(width: PXSpacing.spacingXS),
                            Text('4.5', style: PXTextStyle.styleMBold),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => DealDetailScreen(model: widget.model),
          ),
        );
      },
    );
  }
}

// TODO: Extract to separate component
class CompanyRating extends StatelessWidget {
  final DealModel model;

  CompanyRating({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image.network(
                "https://d1wnwqwep8qkqc.cloudfront.net/uploads/stage/stage_image/41544/optimized_large_thumb_stage.jpg",
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lorem Company',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "⭐⭐⭐⭐⭐️️️ 4.5",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
